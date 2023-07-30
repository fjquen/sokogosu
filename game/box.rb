# frozen_string_literal: true

require 'gosu'
require './module'

class Box
    attr_accessor :x, :y
    attr_reader :w, :h
  
    def initialize(img)
      @img = Gosu::Image.new(img)
      @x = 0
      @y = 0
      @w = @img.width
      @h = @img.height
    end
  
    def draw
      @img.draw(@x, @y)
    end
end