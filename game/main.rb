require 'gosu'
require './player'
require './key'

class Main < Gosu::Window
  WIDTH_WINDOW = 640
  HEIGHT_WINDOW = 480
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW
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
