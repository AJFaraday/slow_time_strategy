class Grid

  attr_accessor :tokens, :x_size, :y_size, :game

  def initialize(x_size, y_size, game)
    @x_size = x_size
    @y_size = y_size
    @game= game
    @x_index = []
    @y_index = []
    @tokens = []
  end

  def add_token(x, y, type=nil, owner=Player.new)
    token = (type || Token).new(x, y, owner, self)

    check_token(token)
    owner.tokens << token
    @tokens << token
    add_token_to_indexes(token)
    token
  end

  def remove_token(x, y)
    token = token_at(x, y)
    @x_index[x].delete(token)
    @y_index[y].delete(token)
    @tokens -= [token]
  end

  def place_token(token, x, y)
    token.x = x
    token.y = y
    add_token_to_indexes(token)
  end

  def move_token(x1, y1, x2, y2)
    token = token_at(x1, y1)
    if token
      remove_token(x1, y1)
      place_token(token, x2, y2)
      check_token(token)
    end
  end

  def token_at(x, y)
    tokens = (@x_index[x] || []) & (@y_index[y] || [])
    tokens ? tokens[0] : false
  end

  def tokens_in_box(x1, y1, x2, y2)
    in_x = @x_index[x1..x2]&.compact&.flatten
    in_y = @y_index[y1..y2]&.compact&.flatten
    (in_x && in_y) ? in_x & in_y : []
  end

  private

  def add_token_to_indexes(token)
    @x_index[token.x] ||= []
    @x_index[token.x] << token

    @y_index[token.y] ||= []
    @y_index[token.y] << token
  end

  def check_token(token)
    errors = []
    if token.x < 0 || token.x >= x_size
      errors << "#{token.x} is out of x range (#{x_size})"
    end
    if token.y < 0 || token.y >= y_size
      errors << "#{token.y} is out of y range (#{y_size})"
    end
    if token_at(token.x, token.y) && token_at(token.x, token.y) != token
      errors << "There is already a token at #{token.x}:#{token.y}"
    end
    if errors.any?
      raise "Can not add token: #{errors.join(' - ')}"
    end
  end

end