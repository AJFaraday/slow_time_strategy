require_relative('../../environment')

describe Geometry do

  include Geometry

  it 'calculates how far 6 is between 2 and 9' do
    expect(range_to_proportion(2, 9, 6)).to be_within(0.01).of(0.57)
  end

  it 'calculates a load of proportions' do
    expect(range_to_proportion(1, 3, 2)).to eq(0.5)

    expect(range_to_proportion(9, 16, 9)).to eq(0)
    expect(range_to_proportion(9, 16, 10)).to be_within(0.001).of(0.142)
    expect(range_to_proportion(9, 16, 11)).to be_within(0.001).of(0.285)
    expect(range_to_proportion(9, 16, 12)).to be_within(0.001).of(0.428)
    expect(range_to_proportion(9, 16, 13)).to be_within(0.001).of(0.571)
    expect(range_to_proportion(9, 16, 14)).to be_within(0.001).of(0.714)
    expect(range_to_proportion(9, 16, 15)).to be_within(0.001).of(0.857)
    expect(range_to_proportion(9, 16, 16)).to eq(1)
  end

  it 'gives me a proportion of the difference between two numbers' do
    expect(proportion_to_step(0, 10, 0)).to eq(0)
    expect(proportion_to_step(0, 10, 0.1)).to eq(1)
    expect(proportion_to_step(0, 10, 0.2)).to eq(2)
    expect(proportion_to_step(0, 10, 0.3)).to eq(3)
    expect(proportion_to_step(0, 10, 0.4)).to eq(4)
    expect(proportion_to_step(0, 10, 0.5)).to eq(5)
    expect(proportion_to_step(0, 10, 0.6)).to eq(6)
    expect(proportion_to_step(0, 10, 0.7)).to eq(7)
    expect(proportion_to_step(0, 10, 0.8)).to eq(8)
    expect(proportion_to_step(0, 10, 0.9)).to eq(9)
    expect(proportion_to_step(0, 10, 1)).to eq(10)
  end

  it 'gives me the proportion between two steps backwards' do
    expect(proportion_to_step(10, 0, 0)).to eq(10)
    expect(proportion_to_step(10, 0, 0.1)).to eq(9)
    expect(proportion_to_step(10, 0, 0.2)).to eq(8)
    expect(proportion_to_step(10, 0, 0.3)).to eq(7)
    expect(proportion_to_step(10, 0, 0.4)).to eq(6)
    expect(proportion_to_step(10, 0, 0.5)).to eq(5)
    expect(proportion_to_step(10, 0, 0.6)).to eq(4)
    expect(proportion_to_step(10, 0, 0.7)).to eq(3)
    expect(proportion_to_step(10, 0, 0.8)).to eq(2)
    expect(proportion_to_step(10, 0, 0.9)).to eq(1)
    expect(proportion_to_step(10, 0, 1)).to eq(0)
  end

  it 'works with subdivisions' do
    expect(proportion_to_step(10, 9, 0.5)).to eq(9.5)
    expect(proportion_to_step(9, 10, 0.5)).to eq(9.5)
  end

end

