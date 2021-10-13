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

  it 'returns a method to heal a friendly token'do
    frinedly_token = game.grid.add_token(5, 8, Walker, game.players[0])
    walker.health = 2
    frinedly_token.health = 5
    walker.owner.direction = 'S'
    walker.calculate_movement.call
    expect(game.grid.token_at(5,7)).to be_nil
    expect(frinedly_token.health).to eq(7)
    expect(game.grid.token_at(5,8)).to eq(frinedly_token)
  end

  # will never happen
  it 'returns a method to attack if it steps onto an enemy' do
    game.add_player('#FF0000')
    enemy = game.grid.add_token(5, 8, Walker, game.players[1])
    walker.health = 2
    enemy.health = 5
    walker.owner.direction = 'S'
    walker.calculate_movement.call
    expect(game.grid.token_at(5,7)).to be_nil
    expect(enemy.health).to eq(3)
    expect(game.grid.token_at(5,8)).to eq(enemy)
  end

end
