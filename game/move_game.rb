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
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                return_move_wall(axe["x"],row_player,col_player,wall,axe)
            when obj_move["u"]
                @y = row_player
                @y -= 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
                return_move_wall(axe["y"],row_player,col_player,wall,axe)
            when obj_move["d"]
                @y = row_player
                @y += 1
                check_collision(row_player,col_player,wall,block,goal,void,win,obj_move,dir_move)
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
                               case dir_move
                                    when obj_move["r"]
                                        @x_push += 1
                                    when obj_move["l"]
                                        @x_push -= 1
                                    else
                                        puts "Valeur inconnu"
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
                                            puts "Valeur inconnu"
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
                                    puts "Valeur inconnu"
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
                                    when obj_move["u"]
                                        @y_push = y-1
                                    when obj_move["d"]
                                        @y_push = y+1
                                    else
                                        puts "Valeur inconnu"
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
                    puts "Valeur inconnu"
            end         
    end
end