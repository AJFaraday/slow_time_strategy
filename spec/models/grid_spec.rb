require_relative('../../lib/environment')

describe Grid do

  let(:grid) { Grid.new(10, 10) }

  it 'adds a valid token' do
    grid.add_token(1, 2)
    expect(grid.tokens.count).to eq(1)
    expect(grid.tokens[0]).to be_a(Token)
    expect(grid.tokens[0].x).to eq(1)
    expect(grid.tokens[0].y).to eq(2)
    grid.add_token(2, 1)
    expect(grid.tokens.count).to eq(2)
    expect(grid.tokens[1]).to be_a(Token)
    expect(grid.tokens[1].x).to eq(2)
    expect(grid.tokens[1].y).to eq(1)
  end

  it 'errors if you add a negative x token' do
    expect { grid.add_token(-1, 0) }.to raise_error("Can not add token: -1 is out of x range (10)")
  end

  it 'errors if you add a negative y token' do
    expect { grid.add_token(0, -1) }.to raise_error("Can not add token: -1 is out of y range (10)")
  end

  it 'errors if you add a large x token' do
    expect { grid.add_token(100, 0) }.to raise_error("Can not add token: 100 is out of x range (10)")
  end

  it 'errors if you add a large y token'do
    expect { grid.add_token(0, 100) }.to raise_error("Can not add token: 100 is out of y range (10)")
  end

  it 'errors if a token is already in a position' do
    grid.add_token(2, 2)
    expect { grid.add_token(2, 2) }.to raise_error("Can not add token: There is already a token at 2:2")
  end

  it 'shows multiple errors' do
    expect { grid.add_token(-1, -1) }.to raise_error("Can not add token: -1 is out of x range (10) - -1 is out of y range (10)")
  end

  it 'finds the token at a coordinate' do
    #expect(grid.token_at(2,2)).to be_nil
    grid.add_token(2,2)
    expect(grid.token_at(2,2)).to be_a(Token)
  end

  it 'finds all tokens in a box' do
    expect(grid.tokens_in_box(1,1,3,3)).to eq([])
    grid.add_token(1,1)
    grid.add_token(2,2)
    grid.add_token(3,3)
    grid.add_token(4,4)
    expect(grid.tokens_in_box(1,1,3,3).count).to eq(3)
    expect(grid.tokens_in_box(1,1,3,3)[0]).to be_a(Token)
  end

end
