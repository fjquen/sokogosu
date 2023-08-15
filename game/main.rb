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
    @count_block = @area1.flatten.count(BLOCK)
    @point_win = 0
    @font = Gosu::Font.new(20)
    @word_end = 'Niveaux terminé'
    @bool = true
  end

  def update

  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RIGHT
       if @area1.empty?
        return @word_end
       else
        right_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
       end
    when Gosu::KB_LEFT
       if @area1.empty?
        return @word_end
       else
        left_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
       end
    when Gosu::KB_UP
       if @area1.empty?
        return @word_end
       else
        up_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
       end
    when Gosu::KB_DOWN
       if @area1.empty?
        return @word_end
       else
        down_move_push(PLAYER,WALL,BLOCK,GOAL,VOID,WIN)
       end
    when Gosu::KB_R
      if @area1.empty?
        return @word_end
      else
      @area1 = [["#","#","#","#","#","#","#","#","#","#","#","#"],
              ["#","","","","","","","","","","","#"],
              ["#","","","","","","","","&","","","#"],
              ["#","","","","@","","","","","","","#"],
              ["#","","","","","","","","*","","","#"],
              ["#","","","","","*","","","","","","#"],
              ["#","","","&","","","","","","","","#"],
              ["#","","","","","","","","","","","#"],
              ["#","#","#","#","#","#","#","#","#","#","#","#"]]
      end
    else
      puts "Mauvaise touche"
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
      @font.draw_text("#{@word_end}", 230, 205, 0, 1, 1, Gosu::Color::BLACK)
      @area1.clear
    end
  end
end
Main.new.show
