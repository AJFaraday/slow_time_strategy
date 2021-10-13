require_relative('../../environment')

describe Token do

  let(:game) do
    game = Game.new('test')
    game.add_player('#000000')
    game
  end

  let(:token) { game.grid.add_token(5, 7, Token, game.players[0]) }

  it 'initializes' do
    expect(token.x).to eq(5)
    expect(token.y).to eq(7)
  end

  it 'takes damage' do
    expect(token.health).to eq(1000)
    token.damage(100)
    expect(game.grid.token_at(token.x, token.y)).to eq(token)
    expect(token.health).to eq(900)
    token.damage(100)
    expect(game.grid.token_at(token.x, token.y)).to eq(token)
    expect(token.health).to eq(800)
    token.damage(800)
    expect(game.grid.token_at(token.x, token.y)).to be_nil
    expect(token.health).to eq(0)
  end

  # .r...
  # .Rb..
  # ..b.b
  it "returns a method to damage it's neighbours" do
    game = Game.new('test')
    player1 = game.add_player('#000000')
    player2 = game.add_player('#FF0000')
    friendly_token = game.grid.add_token(1,0, Walker, player1)
    attacking_token = game.grid.add_token(1,1, Walker, player1)
    enemy1 = game.grid.add_token(2,1, Walker, player2)
    game.grid.remove_token(2,2) # no need for this city
    enemy2 = game.grid.add_token(2,2, Walker, player2)
    safe_enemy = game.grid.add_token(5,3, Walker, player2)

    attacking_token.health = 6
    enemy1.health = 5
    enemy2.health = 10

    action_lambdas = attacking_token.calculate_damage

    expect(friendly_token.health).to eq(1)
    expect(game.grid.token_at(1,0)).to eq(friendly_token)
    expect(attacking_token.health).to eq(6)
    expect(enemy1.health).to eq(5)
    expect(game.grid.token_at(2, 1)).to eq(enemy1)
    expect(enemy2.health).to eq(10)
    expect(safe_enemy.health).to eq(1)

    action_lambdas.each(&:call)

    expect(friendly_token.health).to eq(1)
    expect(game.grid.token_at(1,0)).to eq(friendly_token)
    expect(attacking_token.health).to eq(6)
    expect(enemy1.health).to eq(-1)
    expect(game.grid.token_at(2, 1)).to be_nil
    expect(enemy2.health).to eq(4)
    expect(safe_enemy.health).to eq(1)
  end

  it "throws an error if you try to calculate it's movement directly" do
    expect{ token.calculate_movement }.to raise_error("calculate_movement called on Token, should be City or Walker")
  end

end
