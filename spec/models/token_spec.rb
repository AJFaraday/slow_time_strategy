require_relative('../../lib/environment')

describe Token do

  it 'initializes' do
    token = Token.new(10, 20)
    expect(token.x).to eq(10)
    expect(token.y).to eq(20)
  end

end