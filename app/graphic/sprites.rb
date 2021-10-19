module Graphic

  module Sprites

    def walker_sprite
      Gosu::Image.load_tiles(File.dirname(__FILE__) + '/../../media/walking_square.png', 35, 35)
    end

    def house_sprite
      Gosu::Image.new(File.dirname(__FILE__) + '/../../media/house_small.png')
    end

  end

end