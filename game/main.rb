require 'gosu'

class Main < Gosu::Window
  WIDTH_WINDOW = 640
  HEIGHT_WINDOW = 480


  WIDTH_TILE = 55
  HEIGHT_TILE = 55
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,false
    self.caption = 'sokogosu'
    @area1 = ["#","#","#","#","#","#","#","#","#","#","#","#",
              "#","","","","","","","","","","#","#",
              "#","","","","","","","","","","#","#",
              "#","","","","@","","","","","","#","#",
              "#","","","","","","","","","","#","#",
              "#","","","","","","","","","","#","#",
              "#","","","","","","","","","","#","#",
              "#","","","","","","","","","","#","#",
              "#","#","#","#","#","#","#","#","#","#","#","#"]
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

  def draw_area
    @area1.each do |single,x|
      case single
      when "#"
        Gosu.draw_rect(x*WIDTH_TILE, x / HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::FUCHSIA)
      when ""
        Gosu.draw_rect(y*WIDTH_TILE, x / HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
      when "@"
        Gosu.draw_rect(y*WIDTH_TILE, x / HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::WHITE)
      else
        puts "plus de carré"
      end
    end
  end

  def draw
    draw_area()
  end

end
Main.new.show
