require 'gosu'

class Main < Gosu::Window
  WIDTH_WINDOW = 640
  HEIGHT_WINDOW = 480


  WIDTH_TILE = 55
  HEIGHT_TILE = 55
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,false
    self.caption = 'sokogosu'
    @area1 = [["#","#","#","#","#","#","#","#","#","#","#","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","@","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","#","#","#","#","#","#","#","#","#","#","#"]]
    @x = @y = 0
  end

  def update
    
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RIGHT
      pos_row = @area1.flatten.index("@")
      pos_col = @area1.first.size
      row = pos_row / pos_col
      col = pos_row % pos_col
      @x +=1
      x = @x + col
      @area1[row][col],@area1[row][x] = @area1[row][x],@area1[row][col]
    when Gosu::KB_LEFT
      pos_row = @area1.flatten.index("@")
      pos_col = @area1.first.size
      row = pos_row / pos_col
      col = pos_row % pos_col
      @x -=1
      x = @x + col
      @area1[row][x],@area1[row][col] = @area1[row][col],@area1[row][x]
    end
  end

  def draw
    draw_area()
  end

  def draw_area
    @area1.each_index do |y|
      @area1[y].each_index do |x|
         if @area1[y][x] == "#"
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::FUCHSIA)
         elsif @area1[y][x] == ""
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
         elsif @area1[y][x] == "@"
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::WHITE)
         end
      end
    end
  end

end
Main.new.show
