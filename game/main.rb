require 'gosu'
require './move_game.rb'

class Main < Gosu::Window
  include Move_game
  WIDTH_WINDOW = 640
  HEIGHT_WINDOW = 480
  WIDTH_TILE = 55
  HEIGHT_TILE = 55
  PLAYER = "@"
  WALL = "#"
  BLOCK= "&"
  VOID = ""
  GOAL = "*"
  WIN = "!"
  def initialize
    super WIDTH_WINDOW, HEIGHT_WINDOW,false
    self.caption = 'sokogosu'
    @area1 = [["#","#","#","#","#","#","#","#","#","#","#","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","&","","","#"],
              ["#","","","","@","","","","","","","#"],
              ["#","","","","","","","","*","","","#"],
              ["#","","","","","*","","","","","","#"],
              ["#","","","&","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","#","#","#","#","#","#","#","#","#","#","#"]]
    @x = @y = 0
    @x_push = @y_push = 0
  end

  def update
    
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RIGHT
      right_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
    when Gosu::KB_LEFT
      left_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
    when Gosu::KB_UP
      up_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
    when Gosu::KB_DOWN
      down_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
    end
  end

  def draw
    draw_area()
  end

  def draw_area
    @area1.each_index do |y|
      @area1[y].each_index do |x|
         if @area1[y][x] == WALL
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::FUCHSIA)
         elsif @area1[y][x] == VOID
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
         elsif @area1[y][x] == PLAYER
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::WHITE)
         elsif @area1[y][x] == BLOCK
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::RED)
         elsif @area1[y][x] == GOAL
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::YELLOW)
         elsif @area1[y][x] == WIN
          Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::GREEN)
         end
      end
    end
  end

end
Main.new.show
