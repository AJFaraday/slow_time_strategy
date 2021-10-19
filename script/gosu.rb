require_relative '../environment'

game = Game.new('duel')
game.add_player(Gosu::Color::BLUE)
game.add_player(Gosu::Color::RED)
window = Graphic::Window.new(game)
window.show
game.add_reporter(Graphic::Reporter.new(game, window))

