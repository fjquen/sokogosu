module Move_game
    def right_move(player,wall)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x += 1
        return if @area1[row_player][@x] == wall
            @area1[row_player][col_player],@area1[row_player][@x] = @area1[row_player][@x],@area1[row_player][col_player]
    end 

    def left_move(player,wall)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x -= 1
        return if @area1[row_player][@x] == wall
        @area1[row_player][col_player],@area1[row_player][@x] = @area1[row_player][@x],@area1[row_player][col_player]
    end
    
    def up_move(player,wall)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
        return if @area1[@y][col_player] == wall
        @area1[row_player][col_player],@area1[@y][col_player] = @area1[@y][col_player],@area1[row_player][col_player]
    end

    def down_move(player,wall)
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y += 1
        return if @area1[@y][col_player] == wall
        @area1[row_player][col_player],@area1[@y][col_player] = @area1[@y][col_player],@area1[row_player][col_player]
    end

    def push_box(player,box)
        @area1.each_index do |y|
            @area1[y].each_index do |x|
                if @area1[y][x] == box
                    @pusher.x_box = x
                    @pusher.y_box = y
                end
                if @area1[y][x] == player
                    @pusher.x_player = x
                    @pusher.y_player = y
                end

                @array<<{"xPlayer"=>@pusher.x_player,"yPlayer"=>@pusher.y_player }
                @array<<{"xBox"=>@pusher.x_box,"yBox"=>@pusher.y_box }
            end
        end
        puts @array
    end
end