require_relative('../../environment')

describe Walker do

  let(:game) do
    game = Game.new('test')
    game.add_player('#000000')
    game
  end

  let(:walker) { game.grid.add_token(5, 7, Walker, game.players[0]) }

  it 'initializes' do
    expect(walker.x).to eq(5)
    expect(walker.y).to eq(7)
    expect(walker.health).to eq(1)
    expect(walker.instance_variable_get(:@grid)).to eq(game.grid)
  end

  it 'heals by 1' do
    expect(walker.health).to eq(1)
    walker.heal(1)
    expect(walker.health).to eq(2)
  end

  it 'becomes a city when health is more than 10' do
    expect(game.grid.token_at(walker.x, walker.y)).to eq(walker)
    walker.heal(9)
    expect(game.grid.token_at(walker.x, walker.y)).to be_a(City)
    expect(game.grid.token_at(walker.x, walker.y).health).to eq(10)
  end

  # TODO different directions
  it 'returns a method to take a step' do
    # 5, 7
    action_method = walker.calculate_movement
    expect(walker.x).to eq(5)
    expect(walker.y).to eq(7)
    expect(game.grid.token_at(5, 7)).to eq(walker)
    walker.owner.direction = 'E'
    action_method.call # step East
    expect(game.grid.token_at(5, 7)).to be_nil
    expect(game.grid.token_at(6, 7)).to eq(walker)
    walker.owner.direction = 'S'
    action_method = walker.calculate_movement
    action_method.call # step South
    expect(game.grid.token_at(6, 7)).to be_nil
    expect(game.grid.token_at(6, 8)).to eq(walker)
    walker.owner.direction = 'W'
    action_method = walker.calculate_movement
    action_method.call # step West
    expect(game.grid.token_at(6, 8)).to be_nil
    expect(game.grid.token_at(5, 8)).to eq(walker)
    walker.owner.direction = 'N'
    action_method = walker.calculate_movement
    action_method.call # step West
    expect(game.grid.token_at(5, 8)).to be_nil
    expect(game.grid.token_at(5, 7)).to eq(walker)
  end

  it 'returns a method to heal a friendly token' do
    frinedly_token = game.grid.add_token(5, 8, Walker, game.players[0])
    walker.health = 2
    frinedly_token.health = 5
    walker.owner.direction = 'S'
    walker.calculate_movement.call
    expect(game.grid.token_at(5, 7)).to be_nil
    expect(frinedly_token.health).to eq(7)
    expect(game.grid.token_at(5, 8)).to eq(frinedly_token)
  end

  # will never happen
  it 'returns a method to attack if it steps onto an enemy' do
    game.add_player('#FF0000')
    enemy = game.grid.add_token(5, 8, Walker, game.players[1])
    walker.health = 2
    enemy.health = 5
    walker.owner.direction = 'S'
    walker.calculate_movement.call
    expect(game.grid.token_at(5, 7)).to be_nil
    expect(enemy.health).to eq(3)
    expect(game.grid.token_at(5, 8)).to eq(enemy)
  end

  it 'fights another token if they step onto the same spot' do
    player1 = game.players[0]
    player1.direction = 'E'
    player2 = game.add_player('#FF0000')
    player2.direction = 'W'
    token1 = game.grid.add_token(5, 5, Walker, player1)
    token1.health = 5
    token2 = game.grid.add_token(7, 5, Walker, player2)
    token2.health = 7
    token1.calculate_movement.call
    token2.calculate_movement.call
    expect(game.grid.token_at(5, 5)).to be_nil
    expect(token1.health).to eq(0)
    expect(game.grid.token_at(6, 5)).to eq(token2)
    expect(game.grid.token_at(7, 5)).to be_nil
    expect(token2.health).to eq(2)
  end

  it 'fights another token if they step onto the same spot (other way)' do
    player1 = game.players[0]
    player1.direction = 'E'
    player2 = game.add_player('#FF0000')
    player2.direction = 'W'
    token1 = game.grid.add_token(5, 5, Walker, player1)
    token1.health = 7
    token2 = game.grid.add_token(7, 5, Walker, player2)
    token2.health = 5
    token1.calculate_movement.call
    token2.calculate_movement.call
    expect(game.grid.token_at(5, 5)).to be_nil
    expect(token1.health).to eq(2)
    expect(game.grid.token_at(6, 5)).to eq(token1)
    expect(game.grid.token_at(7, 5)).to be_nil
    expect(token2.health).to eq(0)
  end

  it 'fights another token if they step onto the same spot (tokens matched)' do
    player1 = game.players[0]
    player1.direction = 'E'
    player2 = game.add_player('#FF0000')
    player2.direction = 'W'
    token1 = game.grid.add_token(5, 5, Walker, player1)
    token1.health = 7
    token2 = game.grid.add_token(7, 5, Walker, player2)
    token2.health = 7
    token1.calculate_movement.call
    token2.calculate_movement.call
    expect(game.grid.token_at(5, 5)).to be_nil
    expect(token1.health).to eq(0)
    expect(game.grid.token_at(6, 5)).to be_nil
    expect(game.grid.token_at(7, 5)).to be_nil
    expect(token2.health).to eq(0)
  end

  it 'stops at the edge of the map' do
    game.players[0].direction = 'W'
    walker = game.grid.add_token(1, 5, Walker, game.players[0])
    expect(game.grid.token_at(1, 5)).to be(walker)
    walker.calculate_movement.call
    expect(game.grid.token_at(1, 5)).to be_nil
    expect(game.grid.token_at(0, 5)).to be(walker)

    expect(walker.calculate_movement).to be_nil # no method to do here
    expect(game.grid.token_at(0, 5)).to be(walker)
  end

  it 'stops when it hits a friendly city' do
    walker = game.grid.add_token(0, 2, Walker, game.players[0])
    expect(game.grid.token_at(0, 2)).to be(walker)
    walker.calculate_movement.call
    expect(game.grid.token_at(0, 2)).to be_nil
    expect(game.grid.token_at(1, 2)).to be(walker)
    walker.calculate_movement.call
    expect(game.grid.token_at(1, 2)).to be(walker)
  end

  it 'kills both walkers when two of them meet' do
    game.add_player('#FF0000')
    game.grid.remove_token(2, 2)
    game.grid.remove_token(12, 7)
    walker1 = game.grid.add_token(5, 5, Walker, game.players[0])
    walker2 = game.grid.add_token(5, 6, Walker, game.players[1])
    game.players[0].direction = 'E'
    game.players[1].direction = 'W'
    game.take_turn
    expect(game.grid.tokens).not_to include(walker1)
    expect(game.grid.tokens).not_to include(walker2)
  end

  it 'kills both walkers when two of them meet' do
    game.add_player('#FF0000')
    game.grid.remove_token(2, 2)
    game.grid.remove_token(12, 7)
  end

end
