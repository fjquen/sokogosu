module Move_game
    ##
    # The function `move_push` takes in various parameters and moves the player in a specified
    # direction while checking for collisions with walls, blocks, goals, voids, and wins.
    # 
    # Args:
    #   player: The "player" parameter represents the current position of the player in the game. It
    # could be a coordinate or an object representing the player's position.
    #   wall: The "wall" parameter represents the position of walls in the game area. It is used to
    # check for collisions between the player and walls.
    #   block: The "block" parameter represents the position of the blocks in the game area. It is
    # used to check for collisions between the player and the blocks when moving.
    #   goal: The "goal" parameter represents the position of the goal in the game. It is used to
    # check if the player has reached the goal and won the game.
    #   void: The "void" parameter is likely a representation of empty spaces or areas in the game. It
    # could be used to determine if the player can move into a certain position or if there are any
    # obstacles in that position.
    #   win: The "win" parameter is used to determine the winning condition of the game. It represents
    # the goal or destination that the player needs to reach in order to win the game.
    #   obj_move: The obj_move parameter is a hash that contains the possible movement directions. The
    # keys of the hash represent the direction (e.g., "r" for right, "l" for left, "u" for up, "d" for
    # down), and the values represent the corresponding movement object.
    #   dir_move: The `dir_move` parameter represents the direction in which the player wants to move.
    # It can have one of the following values: "r" (right), "l" (left), "u" (up), or "d" (down).
    #   axe: The `axe` parameter is a hash that contains the coordinates of the axe object. It has two
    # keys: "x" and "y", which represent the x and y coordinates of the axe respectively.
    def move_player_and_check_collisions(player,wall,block,goal,void,win,obj_move,dir_move,axe)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        
        case dir_move
            when obj_move["r"]
                @x = col_player
                @x += 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["x"],row_player,col_player,wall,axe)
            when obj_move["l"]
                @x = col_player
                @x -= 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["x"],row_player,col_player,wall,axe)
            when obj_move["u"]
                @y = row_player
                @y -= 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["y"],row_player,col_player,wall,axe)
            when obj_move["d"]
                @y = row_player
                @y += 1
                @camera_y += 10
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["y"],row_player,col_player,wall,axe) 
            else
                puts "mauvaise valeur objet #{dir_move}"
        end
        
    end

    ##
    # The function `move_object_with_axe` takes in the direction of the axe, the row and column
    # coordinates, the wall character, and the axe object, and swaps the position of the current cell
    # with the cell adjacent to it in the direction of the axe, if there is no wall in between.
    # 
    # Args:
    #   axe_direction: The parameter "axe_direction" represents the direction in which the axe is
    # being swung. It can have two possible values: "x" or "y".
    #   row: The row index of the current position in the area grid.
    #   col: The `col` parameter represents the column index of the current position in the area grid.
    #   wall: The "wall" parameter represents the value of the wall in the game area. It is used to
    # check if the current position of the player is blocked by a wall before making a move.
    #   axe: The parameter "axe" represents the direction of the axe. It can have two possible values:
    # "x" or "y".
    # 
    # Returns:
    #   The code is returning the updated position of the player after moving them to a new position
    # adjacent to a wall.
    def move_object_with_axe(axe_direction,row,col,wall,axe)
        case axe_direction
            when axe["x"]
                return if @area1[row][@x] == wall
                        @area1[row][col],@area1[row][@x] = @area1[row][@x],@area1[row][col]
            when axe["y"]
                return if @area1[@y][col] == wall
                        @area1[row][col],@area1[@y][col] = @area1[@y][col],@area1[row][col]
            else
                puts "mauvaise valeur objet #{axe}"
        end
    end

    ##
    # The function `check_collision` checks for collisions between objects in a game area and performs
    # certain actions based on the type of collision.
    # 
    # Args:
    #   row: The row parameter represents the current row position of the object in the game area.
    #   col: The parameter "col" represents the column index of the current position in the area grid.
    #   wall: The parameter "wall" represents the symbol used to represent walls in the game area.
    #   block: The "block" parameter represents the symbol or value used to represent a block in the
    # game area.
    #   goal: The "goal" parameter represents the symbol for the goal in the game area.
    #   void: The `void` parameter represents an empty space in the game area.
    #   win: The "win" parameter represents the symbol or value that represents a winning position in
    # the game.
    #   obj_move: The `obj_move` parameter is a hash that maps string keys to integer values. It
    # represents the possible movement directions for an object. The keys in the hash represent the
    # direction (e.g., "r" for right, "l" for left, "u" for up, "d")
    #   dir_move: The `dir_move` parameter represents the direction of movement. It can have the
    # following values:
    # 
    # Returns:
    #   The method does not explicitly return a value.
    def check_collision(row,col,wall,block,goal,void,win,obj_move,dir_move)
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[row][@x] == block
                            if row==y && x==@x
                               @x_push = x
                               case dir_move
                                    when obj_move["r"]
                                        @x_push += 1
                                    when obj_move["l"]
                                        @x_push -= 1
                                    else
                                        @x_push = @x_push
                               end
                                
                                if @area1[y][@x_push] == wall && @area1[y][x] == block
                                    @x = col
                                end
                                if @area1[y][@x_push] == goal
                                    @area1[y][@x_push] = void
                                    @area1[y][x] = win
                                    @point_win += 1
                                end
                                if @area1[y][@x_push] == win && @area1[y][x] == block
                                    case dir_move
                                        when obj_move["r"]
                                            @x_push = x-1
                                        when obj_move["l"]
                                            @x_push = x+1
                                        else
                                            @x_push = @x_push
                                    end
                                end
                                return if @area1[y][@x_push] == wall
                                        @area1[y][@x_push],@area1[y][x] = @area1[y][x],@area1[y][@x_push]
                            end
                    elsif @area1[@y][col] == block
                        if col ==x && y==@y
                            @y_push = y
                            case dir_move
                                when obj_move["u"]
                                    @y_push -= 1
                                when obj_move["d"]
                                    @y_push += 1
                                else
                                    @y_push = @y_push
                            end
                            if @area1[@y_push][x] == wall && @area1[y][x] == block
                                @y = row
                            end
                            if @area1[@y_push][x] == goal
                                @area1[@y_push][x] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[@y_push][x] == win && @area1[y][x] == block
                                case dir_move
                                    when obj_move["d"]
                                        @y_push = y-1
                                    when obj_move["u"]
                                        @y_push = y+1
                                    else
                                        @y_push = @y_push
                                end
                            end
                            return if @area1[@y_push][x] == wall
                                    @area1[@y_push][x],@area1[y][x] = @area1[y][x],@area1[@y_push][x]
                        end
                    end
                end
            end
        end
            case dir_move
                when obj_move["r"], obj_move["l"]
                    if @area1[row][@x] == win
                        @x = col
                    end
                    if @area1[row][@x] == goal
                        @x = col
                    end
                when obj_move["u"], obj_move["d"]
                    if @area1[@y][col] == win
                        @y = row
                    end
                    if @area1[@y][col] == goal
                        @y = row
                    end
                else
                    puts "Valeur inconnu dir_move #{@y_push} et #{@x_push}"
            end         
    end
end