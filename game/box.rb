# frozen_string_literal: true

require 'gosu'
require './module'

class Box
    include Module_move
    attr_accessor :boxes

    Struct.new(:img, :x, :y, :w, :h)

    def initialize
        @boxes = []
    end
end