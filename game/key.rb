# frozen_string_literal: true

require 'gosu'
require './module'


class Key
  include Module_move
  attr_accessor :keys, :boxes

  Box = Struct.new(:img, :x, :y)

  def initialize
    @keys = [{ 'img' => 'media/crate_42.png', 'x' => 170, 'y' => 300 },
             { 'img' => 'media/crate_43.png', 'x' => 69, 'y' => 40 },
             { 'img' => 'media/crate_44.png', 'x' => 49, 'y' => 320 },
             { 'img' => 'media/crate_45.png', 'x' => 149, 'y' => 220 }]
    @boxes = []
    @keys.each do |key|
      @boxes << Box.new(Gosu::Image.new(key['img']), key['x'], key['y'])
    end
  end

  def draw
    @keys.each do |key|
      @keys_img = Gosu::Image.new(key['img'])
      @keys_img.draw(key['x'], key['y'], 0)
    end
  end
end
