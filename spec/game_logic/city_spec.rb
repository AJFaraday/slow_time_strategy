require_relative('../../environment')

describe City do

  it 'initializes' do
    token = City.new(10, 20, OpenStruct.new, 'dummy_grid')
    expect(token.x).to eq(10)
    expect(token.y).to eq(20)
    expect(token.health).to eq(10)
    expect(token.instance_variable_get(:@grid)).to eq('dummy_grid')
  end

  context 'calculate_movement' do
    it 'returns a method to add a token' do
      game = Game.new('test')
      game.add_player('#000000')
      token = game.grid.token_at(2, 2)
      # should move east
      action_lambda = token.calculate_movement
      expect(action_lambda).to be_a(Proc)
      expect(game.grid.token_at(3, 2)).to be_nil
      action_lambda.call
      expect(game.grid.token_at(3, 2)).to be_a(Walker)
      expect(game.grid.token_at(3, 2).owner).to eq(token.owner)
      expect(game.grid.token_at(3, 2).health).to eq(1)
    end

    it 'returns a method to heal a friendly walker' do
      game = Game.new('test')
      game.add_player('#000000')
      token = game.grid.token_at(2, 2)
      game.grid.add_token(3,2, Walker, token.owner)
      # should move east
      action_lambda = token.calculate_movement
      expect(action_lambda).to be_a(Proc)
      expect(game.grid.token_at(3, 2).health).to eq(1)
      action_lambda.call
      expect(game.grid.token_at(3, 2).health).to eq(2)
    end

    # This should never actually happen
    it 'returns a method to damage an enemy walker' do
      game = Game.new('test')
      game.add_player('#000000')
      game.add_player('#FF0000')
      token = game.grid.token_at(2, 2)
      game.grid.add_token(3,2, Walker, game.players[1])
      # should move east
      action_lambda = token.calculate_movement
      expect(action_lambda).to be_a(Proc)
      expect(game.grid.token_at(3, 2).health).to eq(1)
      expect(game.grid.token_at(3, 2).owner).to eq(game.players[1])
      action_lambda.call
      expect(game.grid.token_at(3, 2)).to be_nil
    end

    it 'refuses to heal' do
      game = Game.new('test')
      game.add_player('#000000')
      token = game.grid.token_at(2, 2)
      expect(token.health).to eq(10)
      token.heal(1)
      # nothing happened
      expect(token.health).to eq(10)
    end
  end
end
