require 'gosu'
require './module.rb'

class Cube
    include Module_move
    attr_accessor :cube_position

    def initialize
        @cube_position ={'x'=>0.0,'y'=>0.0} 
    end


    

end