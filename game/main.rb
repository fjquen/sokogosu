require 'gosu'
require './player'
require './key'

class Main < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'sokogosu'
  end

  def update
    
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
   
  end
end
Main.new.show
