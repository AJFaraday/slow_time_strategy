require_relative('../../lib/environment')

describe Player do

  let(:player) { Player.new('#ff0000') }

  it 'should initialize' do
    expect(player).to be_a(Player)
    expect(player.tokens).to eq([])
    expect(player.colour).to eq('#ff0000')
  end

  it 'should pass the phase methods on to the token' do
    grid = Grid.new(10, 10)
    expect(player.tokens.count).to eq(0)
    grid.add_token(5, 5, Token, player)
    expect(player.tokens.count).to eq(1)

    expect{player.calculate_movement}.to raise_error("calculate_movement called on Token, should be City or Walker")
    expect{player.enact_damage}.to raise_error("enact_damage called on Token, should be City or Walker")
    expect{player.calculate_damage}.to raise_error("calculate_damage called on Token, should be City or Walker")
    expect{player.enact_damage}.to raise_error("enact_damage called on Token, should be City or Walker")
  end

end
