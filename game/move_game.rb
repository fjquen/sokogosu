module Move_game
    def move_push(player,wall,block,goal,void,win,obj_move,dir_move,axe)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        
        case dir_move
            when obj_move["r"]
                @x = col_player
                @x += 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                return_move_wall(axe["x"],row_player,col_player,wall,axe)
            when obj_move["l"]
                @x = col_player
                @x -= 1
                return_move_wall(axe["x"],row_player,col_player,wall,axe)
            when obj_move["u"]
                @y = row_player
                @y -= 1
                return_move_wall(axe["y"],row_player,col_player,wall,axe)
            when obj_move["d"]
                @y = row_player
                @y += 1
                return_move_wall(axe["y"],row_player,col_player,wall,axe)
            else
                puts "mauvaise valeur objet #{dir_move}"
        end
        
    end

    def return_move_wall(axe_direction,row,col,wall,axe)
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

    def check_collision(row,col,wall,block,goal,void,win,obj_move,dir_move)
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[row][@x] == block
                        if row==y && x==@x
                            @x_push = x
                            @x_push += 1
                            if @area1[y][@x_push] == block && @area1[y][x] == block
                                @x = col
                            end
                            if @area1[y][@x_push] == goal
                                @area1[y][@x_push] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[y][@x_push] == win && @area1[y][x] == block
                                @x_push = x-1
                            end
                            return if @area1[y][@x_push] == wall
                            @area1[y][@x_push],@area1[y][x] = @area1[y][x],@area1[y][@x_push]
                        end
                    end
                end
            end
        end
    end

    def right_move_push(player,wall,block,goal,void,win)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x += 1
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[row_player][@x] == block
                        if row_player==y && x==@x
                            @x_push = x
                            @x_push += 1
                            if @area1[y][@x_push] == block && @area1[y][x] == block
                                @x = col_player
                            end
                            if @area1[y][@x_push] == goal
                                @area1[y][@x_push] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[y][@x_push] == win && @area1[y][x] == block
                                @x_push = x-1
                            end
                            return if @area1[y][@x_push] == wall
                            @area1[y][@x_push],@area1[y][x] = @area1[y][x],@area1[y][@x_push]
                        end
                    end
                end
            end
        end
        if @area1[row_player][@x] == win
            @x = col_player
        end
        if @area1[row_player][@x] == goal
            @x = col_player
        end
        return if @area1[row_player][@x] == wall
            @area1[row_player][col_player],@area1[row_player][@x] = @area1[row_player][@x],@area1[row_player][col_player]
    end 

    def left_move_push(player,wall,block,goal,void,win)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x -= 1
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[row_player][@x] == block
                        if row_player==y && x==@x
                            @x_push = x
                            @x_push -= 1
                            if @area1[y][@x_push] == block && @area1[y][x] == block
                                @x = col_player
                            end
                            if @area1[y][@x_push] == goal
                                @area1[y][@x_push] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[y][@x_push] == win && @area1[y][x] == block
                                @x_push = x+1
                            end
                            return if @area1[y][@x_push] == wall
                            @area1[y][@x_push],@area1[y][x] = @area1[y][x],@area1[y][@x_push]
                        end
                    end
                end
            end
        end
        if @area1[row_player][@x] == win
            @x = col_player
        end
        if @area1[row_player][@x] == goal
            @x = col_player
        end
        return if @area1[row_player][@x] == wall
            @area1[row_player][col_player],@area1[row_player][@x] = @area1[row_player][@x],@area1[row_player][col_player]
    end
    
    def up_move_push(player,wall,block,goal,void,win)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[@y][col_player] == block
                        if col_player==x && y==@y
                            @y_push = y
                            @y_push -= 1
                            if @area1[@y_push][x] == block && @area1[y][x] == block
                                @y = row_player
                            end
                            if @area1[@y_push][x] == goal
                                @area1[@y_push][x] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[@y_push][x] == win && @area1[y][x] == block
                                @y_push = y+1
                            end
                            return if @area1[@y_push][x] == wall
                            @area1[@y_push][x],@area1[y][x] = @area1[y][x],@area1[@y_push][x]
                        end
                    end
                end
            end
        end
        if @area1[@y][col_player] == win
            @y = row_player
        end
        if @area1[@y][col_player] == goal
            @y = row_player
        end
        return if @area1[@y][col_player] == wall
            @area1[row_player][col_player],@area1[@y][col_player] = @area1[@y][col_player],@area1[row_player][col_player]
    end

    def down_move_push(player,wall,block,goal,void,win)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y += 1
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == block
                    if @area1[@y][col_player] == block
                        if col_player==x && y==@y
                            @y_push = y
                            @y_push += 1
                            if @area1[@y_push][x] == block && @area1[y][x] == block
                                @y = row_player
                            end
                            if @area1[@y_push][x] == goal
                                @area1[@y_push][x] = void
                                @area1[y][x] = win
                                @point_win += 1
                            end
                            if @area1[@y_push][x] == win && @area1[y][x] == block
                                @y_push = y-1
                            end
                            return if @area1[@y_push][x] == wall
                            @area1[@y_push][x],@area1[y][x] = @area1[y][x],@area1[@y_push][x]
                        end
                    end
                end
            end
        end
        if @area1[@y][col_player] == win
            @y = row_player
        end
        if @area1[@y][col_player] == goal
            @y = row_player
        end
        return if @area1[@y][col_player] == wall
            @area1[row_player][col_player],@area1[@y][col_player] = @area1[@y][col_player],@area1[row_player][col_player]
    end
end