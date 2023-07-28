require 'gosu'
require './module.rb'
require './cube.rb'

class Key
    include Module_move
     attr_accessor :keys

    def initialize
        @keys = [{'img'=>'media/crate_42.png','x'=>170,'y'=>300},{'img'=>'media/crate_43.png','x'=>69,'y'=>40},{'img'=>'media/crate_44.png','x'=>49,'y'=>320},{'img'=>'media/crate_45.png','x'=>149,'y'=>220}]
        @cube = Cube.new
    end

    def draw
        @keys.each do |key|
            @keys_img = Gosu::Image.new(key['img'])
            @keys_img.draw(key['x'],key['y'],0)
        end
    end
end