module Move_game
    
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
                if @camera_x < @wall_limit_x
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

    def set_win_y(goal,void,win,x,y)
        if @area1[@y_push][x] == goal
            @area1[@y_push][x] = void
            @area1[y][x] = win
            @point_win += 1
        end
    end

    def set_win_x(goal,void,win,x,y)
        if @area1[y][@x_push] == goal
            @area1[y][@x_push] = void
            @area1[y][x] = win
            @point_win += 1
        end
    end

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

    def scrolling(y,x,widthTile, heighTile,camera_y,camera_x,blockColor, axe)
        Gosu.draw_rect(x*widthTile - camera_x, y*heighTile - camera_y, widthTile, heighTile,blockColor)
    end
end