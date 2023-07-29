# frozen_string_literal: true

require 'gosu'
require './player'
require './key'

class Main < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'sokoban'
    @player = Player.new
    @key = Key.new
  end

  def update
    if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::GP_RIGHT)
      @player.move_right
      @player.right_collision_player(@key.keys)
      @player.right_collision_box(@key.keys, @key.boxes)
      @player.num_img_pos = 1
    elsif Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::GP_LEFT)
      @player.move_left
      @player.left_collision(@key.keys)
      @player.num_img_pos = 2
    elsif Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::GP_UP)
      @player.move_top
      @player.up_collision(@key.keys)
      @player.num_img_pos = 3
    elsif Gosu.button_down?(Gosu::KB_DOWN) || Gosu.button_down?(Gosu::GP_DOWN)
      @player.move_down
      @player.down_collision(@key.keys)
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
