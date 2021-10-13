require_relative('../../environment')

describe TurnRunner do

  let(:game) do
    game = Game.new('test')
    game.add_player('#000000')
    game.add_player('#FF0000')
    game
  end

  let(:grid) {game.grid}

  let(:turn_runner) {TurnRunner.new(game)}

  it "initialises" do
    expect(turn_runner).to be_a(TurnRunner)
    expect(turn_runner.game).to eq(game)
  end

  it 'should make listed changes to the grid' do
    # Add walker
    grid.add_token(1, 1, Walker, game.players[0])
    # Cue up a step
    turn_runner.changes << -> { grid.move_token(1, 1, 2, 1)}
    # Nothing changed
    expect(grid.token_at(1, 1)).to be_a(Walker)
    expect(grid.token_at(2, 1)).to be_nil

    # Make the change
    turn_runner.enact_changes
    expect(grid.token_at(1, 1)).to be_nil
    expect(grid.token_at(2, 1)).to be_a(Walker)
  end

  it 'should take the first turn (two Cities spawn)' do
    turn_runner.perform
    # TODO actually check result
  end

end
