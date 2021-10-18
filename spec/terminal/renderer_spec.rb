require_relative '../../environment'

module Terminal

  describe Renderer do

    EXPECTED_BOARD="+------------------------------------------------------------+
|                                                            |
|                                                            |
|        0C10                                                |
|                                                            |
|                                                            |
|                                                            |
|                                                            |
|                                                            |
|                                                            |
|                                                            |
+------------------------------------------------------------+
"


    SECOND_BOARD="+------------------------------------------------------------+
|                                                            |
|                                                            |
|        0C100W01                                            |
|                                                            |
|                                                            |
|                                                            |
|                                                            |
|                                            1W011C10        |
|                                                            |
|                                                            |
+------------------------------------------------------------+
"
    let(:game) {Game.new('test')}
    let (:renderer) {Terminal::Renderer.new(game)}

    it 'initializes with a game' do
      expect(renderer).to be_a(Terminal::Renderer)
      expect(renderer.game).to be(game)
      expect(renderer.x_size).to be(15)
      expect(renderer.y_size).to be(10)
    end

    it 'should draw the board without errors' do
      game.add_player('red')
      board = renderer.draw
      expect(board).to eq(EXPECTED_BOARD)
      game.add_player('blue')
      game.take_turn
      board = renderer.draw
      expect(board).to eq(SECOND_BOARD)
    end

  end

end
