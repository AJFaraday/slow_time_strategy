require_relative('../../lib/environment')

describe City do

  it 'initializes' do
    token = City.new(10, 20, OpenStruct.new, 'dummy_grid')
    expect(token.x).to eq(10)
    expect(token.y).to eq(20)
    expect(token.health).to eq(10)
    expect(token.instance_variable_get(:@grid)).to eq('dummy_grid')
  end

end
