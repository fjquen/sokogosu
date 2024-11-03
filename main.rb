require 'gosu'
require './move_game.rb'
require './constant.rb'


class Main < Gosu::Window
  include Move_game
  include Constant

  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,true,100
    self.caption = 'sokogosu'
    @num_level = 0
    @arr=[]
    File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
        @arr<<line.split("")
    }
    @area1 = @arr
    @x = @y = 0
    pos_row_player = @area1.flatten.index(PLAYER)
    pos_col_player = @area1.first.size
    row_player = pos_row_player / pos_col_player
    col_player = pos_row_player % pos_col_player
    @camera_y = row_player * HEIGHT_TILE - @area1.flatten.count(WALL)
    @camera_x = col_player * WIDTH_TILE - @area1.flatten.count(WALL)
    @x_push = @y_push = 0
    @count_block = @area1.flatten.count(BLOCK)
    @point_win = 0
    @font = Gosu::Font.new(20)
    @word_end = "Niveaux terminé"
    @bool = true
    @bool_draw_again = false
    @xlimit = @ylimit = 0
    @count_wall = @area1.flatten.count(WALL)
  end

  def update
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
      if @area1.empty?
        return @word_end
      else
        move_player_and_check_collisions(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["r"],AXE,WIDTH_TILE)
      end
    end

    if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
      if @area1.empty?
        return @word_end
      else
        move_player_and_check_collisions(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["l"],AXE,WIDTH_TILE)
      end
    end

    if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::GP_UP
      if @area1.empty?
        return @word_end
      else
        move_player_and_check_collisions(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["u"],AXE,WIDTH_TILE)
      end
    end

    if Gosu.button_down? Gosu::KB_DOWN or Gosu.button_down? Gosu::GP_DOWN
      if @area1.empty?
        return @word_end
      else
        move_player_and_check_collisions(PLAYER,WALL,BLOCK,GOAL,VOID,WIN,MOVE,MOVE["d"],AXE,WIDTH_TILE)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_R
      arr = []
      File.foreach(Dir.glob("*txt")[@num_level]) { |line| 
        arr<<line.split("")
      }
      @area1 = arr
      @bool = true
      @point_win = 0
      pos_row_player = @area1.flatten.index(PLAYER)
      pos_col_player = @area1.first.size
      row_player = pos_row_player / pos_col_player
      col_player = pos_row_player % pos_col_player
      @camera_y = row_player * HEIGHT_TILE - @area1.flatten.count(WALL)
      @camera_x = col_player * WIDTH_TILE - @area1.flatten.count(WALL)
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
          @camera_x = @camera_y = 0
          @count_block = @area1.flatten.count(BLOCK)
        else
          close
        end
      end
    end
  end

  def draw
    draw_area()
    draw_font_win()
    draw_font_goal() 
  end

 
  def draw_area
    @area1.each_index do |y|
      @area1[y].each_index do |x|
          @ylimit = @y*HEIGHT_TILE
          @xlimit = @x*WIDTH_TILE
          if @area1[y][x] == WALL
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::BLUE,@axe)
          elsif @area1[y][x] == VOID
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::BLACK,@axe)
          elsif @area1[y][x] == PLAYER
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::WHITE,@axe)
          elsif @area1[y][x] == BLOCK
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::RED,@axe)
          elsif @area1[y][x] == GOAL
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::GRAY,@axe)
          elsif @area1[y][x] == WIN
            scrolling(y,x,WIDTH_TILE,HEIGHT_TILE,@camera_y,@camera_x,Gosu::Color::GREEN,@axe)
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

  def draw_font_goal
    if @bool
      @font.draw_text("Nombre d'objectif atteint : #{@point_win}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end
end
Main.new.show
