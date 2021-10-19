require_relative('../../environment')

describe Player do

  let(:player) { Player.new('#ff0000') }

  it 'should initialize' do
    expect(player).to be_a(Player)
    expect(player.tokens).to eq([])
    expect(player.colour).to eq('#ff0000')
  end

end
