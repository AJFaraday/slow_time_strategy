class Grid

  attr_accessor :tokens, :x_size, :y_size

  def initialize(x_size, y_size)
    @x_size = x_size
    @y_size = y_size
    @x_index = []
    @y_index = []
    @tokens = []
  end

  def add_token(x, y)
    token = Token.new(x, y)

    check_token(token)
    @tokens << token

    # add token to indexes
    @x_index[token.x] ||= []
    @x_index[token.x] << token

    @y_index[token.y] ||= []
    @y_index[token.y] << token
  end

  def token_at(x, y)
    tokens = @x_index[x] & @y_index[y]
    tokens ? tokens[0] : false
  end

  def tokens_in_box(x1, y1, x2, y2)
    in_x = @x_index[x1..x2]&.compact&.flatten
    in_y = @y_index[y1..y2]&.compact&.flatten
    (in_x && in_y) ? in_x & in_y : []
  end

  private

  def check_token(token)
    errors = []
    if token.x < 0 || token.x >= x_size
      errors << "#{token.x} is out of x range (#{x_size})"
    end
    if token.y < 0 || token.y >= y_size
      errors << "#{token.y} is out of y range (#{y_size})"
    end
    if token_at(token.x, token.y)
      errors << "There is already a token at #{token.x}:#{token.y}"
    end
    if errors.any?
      raise "Can not add token: #{errors.join(' - ')}"
    end
  end

end