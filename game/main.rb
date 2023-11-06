require 'gosu'
require './move_game.rb'
require './constant.rb'


class Main < Gosu::Window
  include Move_game
  include Constant

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

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RIGHT,Gosu::GP_RIGHT
       if @area1.empty?
        return @word_end
       else
        #right_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["r"],AXE)
       end
    when Gosu::KB_LEFT,Gosu::GP_LEFT
       if @area1.empty?
        return @word_end
       else
        #left_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["l"],AXE)
       end
    when Gosu::KB_UP,Gosu::GP_UP
       if @area1.empty?
        return @word_end
       else
        #up_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
        move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["u"],AXE)
       end
    when Gosu::KB_DOWN,Gosu::GP_DOWN
       if @area1.empty?
        return @word_end
       else
        #down_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
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
          File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
            @arr<<line.split("")
          }
        else
          close
        end
        
        @area1 = @arr
        @bool = true
        @point_win = 0
        @count_block = @area1.flatten.count(BLOCK)
      end
    end
  end

  def draw
    draw_area()
    draw_font_win()
    if @bool
      @font.draw_text("Nombre d'objectif atteint : #{@point_win}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end

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
  
  def draw_font_win
    if @count_block == @point_win
      @bool = false
      Gosu.draw_rect(100, 190, 400, 50, Gosu::Color::WHITE)
      @font.draw_text("#{@word_end} les #{@point_win} blocs sont arrivés", 130, 205, 0, 1, 1, Gosu::Color::BLACK)
      @area1.clear
    end
  end
end
Main.new.show
