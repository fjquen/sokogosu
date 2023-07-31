require 'gosu'

class Main < Gosu::Window
  WIDTH_WINDOW = 640
  HEIGHT_WINDOW = 480


  WIDTH_TILE = 55
  HEIGHT_TILE = 55
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,false
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
    Gosu.draw_rect(WIDTH_TILE, HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::FUCHSIA)
  end
end
Main.new.show
