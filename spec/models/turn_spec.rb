require_relative('../../lib/environment')

describe Turn do

  let(:game) do
    game = Game.new('duel')
    game.add_player('#000000')
    game.add_player('#FF0000')
    game
  end

  let(:turn) {Turn.new(game)}

  it "initialises" do
    expect(turn).to be_a(Turn)
    expect(turn.game).to eq(game)
    expect(turn.grid).to eq(game.grid)
    expect(turn.players).to eq(game.players)
  end

  it 'should make listed changes to the grid' do
    # Add walker
    turn.grid.add_token(1,1, Walker, game.players[0])
    # Cue up a step
    turn.changes << -> { turn.grid.move_token(1,1,2,1)}
    # Nothing changed
    expect(turn.grid.token_at(1,1)).to be_a(Walker)
    expect(turn.grid.token_at(2,1)).to be_nil

    # Make the change
    turn.enact_changes
    expect(turn.grid.token_at(1,1)).to be_nil
    expect(turn.grid.token_at(2,1)).to be_a(Walker)
  end

  it 'should '

end