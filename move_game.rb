module Move_game
    
    ##
    # This Ruby function `move_player_and_check_collisions` updates the player's position and checks
    # for collisions with walls, blocks, goals, and void spaces in a game environment.
    # 
    # Args:
    #   player: The `player` parameter in the `move_player_and_check_collisions` method represents the
    # current position of the player in the game area. It is used to determine the player's row and
    # column position within the game grid.
    #   wall: The `wall` parameter in the `move_player_and_check_collisions` method represents the
    # walls in the game area. Walls are obstacles that the player cannot pass through. The function
    # uses the `wall` parameter to check for collisions between the player and the walls to prevent
    # the player from moving through them
    #   block: The `block` parameter in the `move_player_and_check_collisions` method represents the
    # block object in the game. It is used to check for collisions with the player when moving in
    # different directions (up, down, left, right). The method will handle interactions between the
    # player and the block object
    #   goal: The `goal` parameter in the `move_player_and_check_collisions` method likely represents
    # the location of the goal or endpoint in the game level. It is used to check for collisions with
    # the player to determine if the player has reached the goal and won the game. The method likely
    # includes logic to
    #   void: In the provided code snippet, the `void` parameter seems to be a placeholder for a
    # specific type of object or element that is involved in the game logic. It is likely used to
    # represent an area or space within the game environment where certain actions or interactions are
    # not allowed or have specific consequences.
    #   win: The `win` parameter in the `move_player_and_check_collisions` method seems to be used as
    # a flag or indicator to determine if the player has won the game. It is likely being checked in
    # the `check_collision` method to see if the player has reached the goal or completed the game
    #   obj_move: obj_move is a hash containing directions as keys and corresponding values. The
    # directions can be "r" for right, "l" for left, "u" for up, and "d" for down. This hash is used
    # to determine the direction in which the player should move.
    #   dir_move: The `dir_move` parameter in the `move_player_and_check_collisions` method represents
    # the direction in which the player is moving. It is used to determine the movement of the player
    # within the game environment. The possible values for `dir_move` are defined in the `obj_move`
    # hash,
    #   axe: The `axe` parameter in the `move_player_and_check_collisions` method seems to be used for
    # specifying the position of an axe object in the game. It appears to be a hash containing keys
    # for the x and y coordinates of the axe object. The method `move_object_with_axe`
    #   tile: The `tile` parameter in the `move_player_and_check_collisions` method represents the
    # size of each tile in your game grid. This value is used to determine how much the camera should
    # move when the player moves in a certain direction. It helps in controlling the camera movement
    # and ensuring that the player
    def move_player_and_check_collisions(player,wall,block,goal,void,win,obj_move,dir_move,axe,tile)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @wall_limit_x = @xlimit - @count_wall
        @wall_limit_y = @ylimit - @count_wall
        case dir_move
            when obj_move["r"]
                @x = col_player
                @x += 1
                if @camera_x <@wall_limit_x
                    @camera_x += tile
                end
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["x"],row_player,col_player,wall,axe)
            when obj_move["l"]
                @x = col_player
                @x -= 1
                if @camera_x>@wall_limit_x
                    @camera_x -= tile
                end
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["x"],row_player,col_player,wall,axe)
            when obj_move["u"]
                @y = row_player
                @y -= 1
                if @camera_y>@wall_limit_y
                    @camera_y -= tile
                end
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["y"],row_player,col_player,wall,axe)
            when obj_move["d"]
                @y = row_player
                @y += 1
                if @camera_y <@wall_limit_y
                    @camera_y += tile
                end
                
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                move_object_with_axe(axe["y"],row_player,col_player,wall,axe) 
            else
                puts "mauvaise valeur objet #{dir_move}"
        end
        
    end

    
    ##
    # This Ruby function moves an object in a 2D area based on a given axe direction.
    # 
    # Args:
    #   axe_direction: The `axe_direction` parameter is used to determine whether the object should be
    # moved horizontally or vertically based on the direction specified.
    #   row: The `row` parameter in the `move_object_with_axe` method represents the row index of the
    # object you want to move within the area grid. It specifies the vertical position of the object
    # within the grid.
    #   col: It seems like you were about to ask about the `col` parameter in the
    # `move_object_with_axe` method. The `col` parameter represents the column index where the object
    # is currently located or where you want to move the object to within the 2D area grid.
    #   wall: The `wall` parameter in the `move_object_with_axe` method represents the symbol or value
    # that indicates a wall or obstacle in the game area. This is used to check if the object can move
    # to a specific position based on the presence of a wall at that location.
    #   axe: It seems like the `axe` parameter is a hash containing information about the direction of
    # the axe. The method `move_object_with_axe` takes in the direction of the axe, row and column
    # coordinates, a wall object, and the axe object as parameters.
    # 
    # Returns:
    #   In the `move_object_with_axe` method, the code is returning `nil` if the conditions specified
    # in the `case` statement are not met. If the conditions are met, the method performs the object
    # movement within the `@area1` array based on the axe direction provided.
    def move_object_with_axe(axe_direction,row,col,wall,axe)
        case axe_direction
            when axe["x"]
                return if @area1[row][@x] == wall
                        @area1[row][col],@area1[row][@x] = @area1[row][@x],@area1[row][col]
            when axe["y"]
                return if @area1[@y][col] == wall
                        @area1[row][col],@area1[@y][col] = @area1[@y][col],@area1[row][col]
        end
    end

    
    ##
    # This Ruby function checks for collisions between objects in a game area and handles movement
    # accordingly.
    # 
    # Args:
    #   row: The `row` parameter in the `check_collision` method represents the current row position
    # in the game area grid where the collision check is being performed. It is used to determine the
    # position of the block in the row for collision detection and handling.
    #   col: The `col` parameter in the `check_collision` method represents the column index in the
    # game area grid where the collision check is being performed. It is used to determine if there is
    # a collision with a block element at the specified column index in the grid.
    #   wall: The `wall` parameter in the `check_collision` method represents the symbol or value used
    # to denote a wall in the game area grid. Walls are obstacles that block movement of certain game
    # elements.
    #   block: It looks like the `block` parameter in the `check_collision` method represents a
    # specific type of object in the game area. The method is checking for collisions involving this
    # block object with other elements such as walls, goals, void spaces, and other objects that can
    # move.
    #   goal: The `goal` parameter in the `check_collision` method represents the symbol or value that
    # indicates the goal position in the game area. This parameter is used to check if the block has
    # reached the goal position during collision detection and handling logic within the game.
    #   void: The `void` parameter in the `check_collision` method seems to represent an empty space
    # in the game area. It is likely used to check if a particular position in the game area is empty
    # or not. In the context of the code snippet you provided, the `void` parameter is probably used
    #   win: The `win` parameter in the `check_collision` method seems to be used to represent the
    # position of the win condition in the game area. It is likely used to check if the block has
    # reached the win condition after a move. The method appears to handle collision detection and
    # movement of blocks within the
    #   obj_move: It seems like the `obj_move` parameter in the `check_collision` method is used to
    # determine the movement of an object. This parameter likely contains information about how the
    # object should move, such as direction or distance. The method uses this information to handle
    # collisions with walls, blocks, goals, and
    #   dir_move: The `dir_move` parameter in the `check_collision` method seems to represent the
    # direction of movement. It is likely used to determine the direction in which the block should be
    # moved based on the collision detection logic within the method. The value of `dir_move` could be
    # something like "up",
    # 
    # Returns:
    #   The `check_collision` method returns after performing the necessary block movements and
    # checking for collisions with walls.
    def check_collision(row,col,wall,block,goal,void,win,obj_move,dir_move)
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[row][@x] == block
                            if row==y && x==@x
                                push_x(x,y,dir_move,obj_move,block,wall)
                                set_win_x(goal,void,win,x,y)
                                push_win_block_x(win,block,dir_move,obj_move,x,y)
                                return if @area1[y][@x_push] == wall
                                        @area1[y][@x_push],@area1[y][x] = @area1[y][x],@area1[y][@x_push]
                            end
                    elsif @area1[@y][col] == block
                            if col ==x && y==@y
                                push_y(x,y,dir_move,obj_move,block,wall)
                                set_win_y(goal,void,win,x,y)
                                push_win_block_y(win,block,dir_move,obj_move,y,x)
                                return if @area1[@y_push][x] == wall
                                        @area1[@y_push][x],@area1[y][x] = @area1[y][x],@area1[@y_push][x]
                            end
                    end
                end
            end
        end
        block_move_goal_win(dir_move, obj_move,col,row,win,goal)            
    end


    ##
    # This Ruby function `block_move_goal_win` is designed to move an object within a 2D area based on
    # specified directions, checking for win or goal conditions.
    # 
    # Args:
    #   dir_move: The `dir_move` parameter in the `block_move_goal_win` method represents the
    # direction of movement. It is used to determine the direction in which the object is moving
    # (e.g., right, left, up, down).
    #   obj_move: The `obj_move` parameter seems to be a hash containing movement directions. The keys
    # in the hash are likely representing different directions such as "r" for right, "l" for left,
    # "u" for up, and "d" for down. These keys are used in the `case
    #   col: The `col` parameter in the `block_move_goal_win` method represents the column index in a
    # 2D array (`@area1`) where the object is trying to move.
    #   row: The `row` parameter in the `block_move_goal_win` method represents the row index in a 2D
    # array (`@area1`) where the movement is being made. It is used to determine the current row
    # position of the object being moved within the game area.
    #   win: The `win` parameter in the `block_move_goal_win` method represents the symbol that
    # indicates a winning condition in the game. When the player reaches a position in the game where
    # the symbol matches the `win` symbol, it signifies that the player has won the game.
    #   goal: The `goal` parameter in the `block_move_goal_win` method represents the target location
    # that the object being moved is trying to reach within the game area. The method checks if the
    # object reaches this goal position after a move in a specified direction. If the object reaches
    # the goal, the method updates
    def block_move_goal_win(dir_move, obj_move,col,row,win,goal)
        begin
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
            end
        rescue => e
            puts "Une exception est levé dans dir_move_goal_win: #{e}"
        end
    end

    ##
    # This Ruby function sets a specific element in a 2D array to a new value if a certain condition
    # is met.
    # 
    # Args:
    #   goal: The `goal` parameter represents the value that you are trying to achieve or reach in the
    # context of the `set_win_y` method.
    #   void: The `void` parameter in the `set_win_y` method likely represents the value that will be
    # replaced in the game area. When the method is called, if the value at `@area1[@y_push][x]` is
    # equal to `goal`, then that value will be replaced with
    #   win: The `win` parameter in the `set_win_y` method represents the value that will be set in
    # the `@area1` array at position `[y][x]` if the condition `@area1[@y_push][x] == goal` is met.
    #   x: The `x` parameter in the `set_win_y` method represents the column index in a 2D array where
    # the operation is being performed.
    #   y: The `y` parameter in the `set_win_y` method represents the row index in a 2D array
    # (`@area1`) where the goal, void, and win values are being manipulated.
    def set_win_y(goal,void,win,x,y)
        if @area1[@y_push][x] == goal
            @area1[@y_push][x] = void
            @area1[y][x] = win
            @point_win += 1
        end
    end

    ##
    # This Ruby function updates a 2D array by replacing a specific element with another element based
    # on certain conditions.
    # 
    # Args:
    #   goal: The `goal` parameter represents the value that you are trying to achieve or reach in the
    # `@area1` array at position `[@x_push, y]`.
    #   void: The `void` parameter in the `set_win_x` method likely represents the value that will be
    # replaced in the game area. When the method is called, if the value at the specified coordinates
    # matches the `goal`, it will be replaced with the `void` value.
    #   win: The `win` parameter in the `set_win_x` method represents the value that will be set in
    # the `@area1` array at the specified coordinates `(y, x)` if the condition is met.
    #   x: The `x` parameter in the `set_win_x` method represents the new x-coordinate where the `win`
    # value will be set in the `@area1` array.
    #   y: The parameter `y` in the `set_win_x` method represents the row index in a two-dimensional
    # array `@area1`. It is used to specify the row where the operation will be performed to set a
    # particular value (`win`) at a specific column index (`x`) if the condition is
    def set_win_x(goal,void,win,x,y)
        if @area1[y][@x_push] == goal
            @area1[y][@x_push] = void
            @area1[y][x] = win
            @point_win += 1
        end
    end


    ##
    # The function `push_x` in Ruby is designed to handle movement and collision detection for a block
    # in a specified direction within a 2D area.
    # 
    # Args:
    #   x: The `x` parameter in the `push_x` method represents the current x-coordinate of the object
    # being pushed. It is used to determine the position of the object in the horizontal direction
    # within the game area.
    #   y: The parameter `y` in the `push_x` method represents the current y-coordinate of the object
    # being moved in a 2D grid or array. It is used to determine the row in which the object is
    # located within the grid.
    #   dir_move: The `dir_move` parameter in the `push_x` method represents the direction in which
    # the object is moving. It is used to determine whether the object is moving to the right or left.
    #   obj_move: obj_move is a hash that contains the directions for movement. It likely has keys "r"
    # for right and "l" for left, with corresponding values indicating movement in those directions.
    #   block: The `block` parameter in the `push_x` method represents the symbol or value that
    # indicates a block in the game area grid. In the provided code snippet, the method is checking if
    # the current position and the next position in the specified direction contain a block. If both
    # positions contain a block,
    #   wall: The `wall` parameter in the `push_x` method represents the symbol or value that
    # indicates a wall in the game area grid. In the provided code snippet, the method checks if the
    # element at the position [@x_push, y] in the game area grid is equal to the `wall`
    def push_x(x,y,dir_move,obj_move,block,wall)
        @x_push = x
        case dir_move
             when obj_move["r"]
                 @x_push += 1
             when obj_move["l"]
                 @x_push -= 1
        end
         
        if @area1[y][@x_push] == wall && @area1[y][x] == block
            @x = x - 1
        elsif @area1[y][@x_push] == block && @area1[y][x] == block
            case dir_move
                when obj_move["r"]
                    @x_push = x-1
                when obj_move["l"]
                    @x_push = x+1
            end
        end
    end

    ##
    # This Ruby function is designed to handle pushing a block in a specified direction within a game
    # area grid.
    # 
    # Args:
    #   x: The parameter `x` in the `push_y` method represents the current x-coordinate of the object
    # being moved.
    #   y: The `y` parameter in the `push_y` method represents the current y-coordinate of an object
    # in a 2D grid. It is used to determine the vertical position of the object within the grid.
    #   dir_move: The `dir_move` parameter in the `push_y` method represents the direction in which
    # the object is moving. It is used to determine whether the object is moving up or down.
    #   obj_move: obj_move is a hash containing directions as keys and their corresponding values. For
    # example, obj_move["u"] represents the movement direction "up" and obj_move["d"] represents the
    # movement direction "down".
    #   block: The `block` parameter in the `push_y` method represents a block object in the game. It
    # is used to check if the current position and the next position in the vertical direction contain
    # a block. The method logic involves moving the block vertically based on certain conditions and
    # interactions with other objects in the
    #   wall: The `wall` parameter in the `push_y` method represents the symbol or value that
    # indicates a wall in the game area grid. This value is used to check if the next position in the
    # specified direction is a wall before moving an object (block) in that direction.
    def push_y(x,y,dir_move,obj_move,block,wall)
        @y_push = y
        case dir_move
            when obj_move["u"]
                @y_push -= 1
            when obj_move["d"]
                @y_push += 1
        end
        if @area1[@y_push][x] == wall && @area1[y][x] == block
            @y = y+1
        elsif @area1[@y_push][x] == block && @area1[y][x] == block
            case dir_move
                when obj_move["d"]
                    @y_push = y-1
                when obj_move["u"]
                    @y_push = y+1
            end
        end
    end

    ##
    # The function `push_win_block_x` checks if a specific condition is met and updates the value of
    # `@x_push` accordingly.
    # 
    # Args:
    #   win: The `win` parameter in the `push_win_block_x` method represents the element that needs to
    # be pushed.
    #   block: The `block` parameter in the `push_win_block_x` method represents the block object that
    # needs to be pushed in the game.
    #   dir_move: The `dir_move` parameter in the `push_win_block_x` method represents the direction
    # in which the block is being moved. It is used to determine how the `@x_push` variable should be
    # updated based on the movement direction specified by `obj_move`.
    #   obj_move: obj_move is a hash containing directions as keys and their corresponding values. For
    # example, obj_move["r"] represents the right direction and obj_move["l"] represents the left
    # direction.
    #   x: The parameter `x` in the `push_win_block_x` method represents the current x-coordinate
    # position within the game area grid where the block is located.
    #   y: The parameter `y` in the `push_win_block_x` method represents the vertical position or row
    # index in the game area grid where the win and block elements are being checked for a specific
    # condition.
    def push_win_block_x(win,block,dir_move,obj_move,x,y)
        if @area1[y][@x_push] == win && @area1[y][x] == block
            case dir_move
                when obj_move["r"]
                    @x_push = x-1
                when obj_move["l"]
                    @x_push = x+1
            end
        end
    end

    

    ##
    # This Ruby function checks if a specific condition is met and updates the value of a variable
    # accordingly.
    # 
    # Args:
    #   win: The `win` parameter in the `push_win_block_y` method represents the element that needs to
    # be pushed.
    #   block: The `block` parameter in the `push_win_block_y` method represents the block object that
    # needs to be pushed in the game.
    #   dir_move: The `dir_move` parameter in the `push_win_block_y` method represents the direction
    # in which the object is moving. It is used to determine how the `@y_push` variable should be
    # updated based on the movement of the object.
    #   obj_move: It seems like the `obj_move` parameter is a hash or dictionary containing keys for
    # different directions. In this case, it looks like it has keys for "d" and "u" representing down
    # and up movements respectively.
    #   y: The parameter `y` in the `push_win_block_y` method represents the current y-coordinate
    # position in the game area grid where the block is located.
    #   x: The `x` parameter in the `push_win_block_y` method represents the x-coordinate of the block
    # in the game area. It is used to determine the position of the block within the game area grid.
    def push_win_block_y(win,block,dir_move,obj_move,y,x)
        if @area1[@y_push][x] == win && @area1[y][x] == block
            case dir_move
                when obj_move["d"]
                    @y_push = y-1
                when obj_move["u"]
                    @y_push = y+1
            end
        end
    end

    ##
    # The function `scrolling` draws a rectangle with specified dimensions and color at a given
    # position adjusted by the camera's position.
    # 
    # Args:
    #   y: The `y` parameter represents the vertical position of the tile in the grid.
    #   x: The `x` parameter in the `scrolling` method represents the horizontal position of the tile
    # on the grid. It is used to calculate the actual screen position of the tile based on the tile
    # width and the camera position.
    #   widthTile: The `widthTile` parameter represents the width of a single tile in your game world.
    # It is used to calculate the actual x-coordinate where the block should be drawn on the screen
    # based on the tile coordinates.
    #   heighTile: The `heighTile` parameter in the `scrolling` method represents the height of each
    # tile in the game world. This value is used to calculate the position at which the block should
    # be drawn on the screen based on the tile coordinates `x` and `y`.
    #   camera_y: The `camera_y` parameter represents the vertical position of the camera in the game
    # world. It is used to determine the offset at which the block should be drawn on the screen based
    # on the camera's position.
    #   camera_x: The `camera_x` parameter represents the x-coordinate of the camera in your game. It
    # is used to determine the offset for drawing objects on the screen, allowing you to create a
    # scrolling effect by adjusting the camera position.
    #   blockColor: The `blockColor` parameter in the `scrolling` method represents the color of the
    # block that will be drawn on the screen. It is used to specify the color of the rectangle that
    # will be drawn at the given `x` and `y` coordinates on the screen. You can pass a
    #   axe: The `axe` parameter in the `scrolling` method seems to be missing from the provided
    # information. Could you please provide more details or context about what the `axe` parameter is
    # supposed to represent or be used for in the method?
    def scrolling(y,x,widthTile, heighTile,camera_y,camera_x,blockColor, axe)
        Gosu.draw_rect(x*widthTile - camera_x, y*heighTile - camera_y, widthTile, heighTile,blockColor)
    end
end