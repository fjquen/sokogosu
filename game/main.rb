require 'gosu'
require './player.rb'
require './key.rb'
require './cube.rb'

class Main < Gosu::Window
    
    def initialize
        super 640,480
        self.caption = "sokoban"
        @player = Player.new
        @key = Key.new
        @cube = Cube.new
    end
    
    def update
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
            @player.right_collision(@key)
            @key.collisions
            @player.num_img_pos = 1
        elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
            @player.left_collision(@key)
            @player.num_img_pos = 2
        elsif Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP
            @player.move_top
            @player.up_collision(@key)
            @player.num_img_pos = 3
        elsif Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN
            @player.move_down
            @player.down_collision(@key)
            @player.num_img_pos = 0
        else
            @player.num_img_pos = 0
        end
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::KB_SPACE
            puts 'yo'
        end
    end

    def draw
       @player.draw
       @key.draw
    end
end
Main.new.show