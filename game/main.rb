require 'gosu'
require './move_game.rb'
require './constant.rb'


class Main < Gosu::Window
  include Move_game
  include Constant

  # The `initialize` method is a special method in Ruby classes that is automatically called when a
  # new instance of the class is created. In this case, the `initialize` method is defining the
  # initial state of the `Main` class.
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,false
    self.caption = 'sokogosu'
    @num_level = 0
    @arr=[]
    File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
        @arr<<line.split("")
    }
    @area1 = @arr
    @x = @y = 0
    @x_push = @y_push = 0
    @count_block = @area1.flatten.count(BLOCK)
    @point_win = 0
    @font = Gosu::Font.new(20)
    @word_end = "Niveaux terminé"
    @bool = true
    @bool_draw_again = false
    
  end

  def update

  end

  # The `button_down` method is a callback method in the Gosu library that is called whenever a button
  # is pressed. It takes an `id` parameter that represents the ID of the button that was pressed.
  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RIGHT,Gosu::GP_RIGHT
       if @area1.empty?
        return @word_end
       else
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["r"],AXE)
       end
    when Gosu::KB_LEFT,Gosu::GP_LEFT
       if @area1.empty?
        return @word_end
       else
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["l"],AXE)
       end
    when Gosu::KB_UP,Gosu::GP_UP
       if @area1.empty?
        return @word_end
       else
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["u"],AXE)
       end
    when Gosu::KB_DOWN,Gosu::GP_DOWN
       if @area1.empty?
        return @word_end
       else
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["d"],AXE)
       end
    when Gosu::KB_R
      arr = []
      File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
        arr<<line.split("")
      }
      @area1 = arr
      @bool = true
      @point_win = 0
      
    when Gosu::KB_A
      if @count_block == @point_win
        @num_level+=1
        if @num_level < Dir.glob("*txt").length
          arr = []
          File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
            arr<<line.split("")
          }
          @area1 = arr
          @bool = true
          @point_win = 0
          @count_block = @area1.flatten.count(BLOCK)
        else
          close
        end
      end
    end
  end

  ##
  # The function "draw" is used to draw an area, a font for winning, and a font for the goal.
  def draw
    draw_area()
    draw_font_win()
    draw_font_goal() 
  end

 ##
 # The `draw_area` function is used to draw different colored rectangles on a grid based on the values
 # in the `@area1` array.
  def draw_area
    @area1.each_index do |y|
      @area1[y].each_index do |x|
         if @area1[y][x] == WALL
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLUE)
         elsif @area1[y][x] == VOID
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
         elsif @area1[y][x] == PLAYER
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::WHITE)
         elsif @area1[y][x] == BLOCK
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::RED)
         elsif @area1[y][x] == GOAL
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::GRAY)
         elsif @area1[y][x] == WIN
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::GREEN)
         end
      end
    end
  end

 ##
 # The function `draw_font_win` checks if the count of blocks is equal to the point to win, and if so,
 # it displays a message on the screen.
  def draw_font_win
    if @count_block == @point_win
      @bool = false
      Gosu.draw_rect(100, 190, 400, 50, Gosu::Color::WHITE)
      @font.draw_text("#{@word_end} les #{@point_win} blocs sont arrivés", 130, 205, 0, 1, 1, Gosu::Color::BLACK)
      @area1.clear
    end
  end

  def draw_font_goal
    if @bool
      @font.draw_text("Nombre d'objectif atteint : #{@point_win}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end
end
Main.new.show
