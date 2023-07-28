require 'gosu'
require './module.rb'
require './cube.rb'

class Player
   include Module_move
    attr_accessor :x, :y,:num_img_pos

    def initialize
        @img_position_player = ["media/player_05.png","media/player_11.png","media/player_14.png","media/player_02.png"]
        @num_img_pos = 0
        @player = Gosu::Image.new(@img_position_player[@num_img_pos])
        @x=@y= 0.0
        @x_speed= @y_speed =7.0
        @cube = Cube.new
    end

    def draw
       @player = Gosu::Image.new(@img_position_player[@num_img_pos])
       @player.draw(@x,@y,0)
    end
end