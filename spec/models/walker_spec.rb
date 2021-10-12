require_relative('../../lib/environment')

describe Walker do

  it 'initializes' do
    token = Walker.new(10, 20, Player.new,'dummy_grid')
    expect(token.x).to eq(10)
    expect(token.y).to eq(20)
    expect(token.health).to eq(1)
    expect(token.instance_variable_get(:@grid)).to eq('dummy_grid')
  end

end
