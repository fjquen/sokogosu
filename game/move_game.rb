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
        pos_row_player = @area1.flatten.index(player)
        pos_col_player = @area1.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x += 1

        pos_row_box = @area1.flatten.index(box)
        pos_col_box = @area1.first.size
        row_box = pos_row_box / pos_col_box
        col_box = pos_row_box % pos_col_box
        @x_push = col_box
        @x_push += 1
        return if @area1[row_player][@x] == @area1[row_box][@x_push]
            puts 'u'
            @area1[row_box][col_box],@area1[row_box][@x_push] = @area1[row_box][@x_push],@area1[row_box][col_box]
            @area1[row_player][@x],@area1[row_box][@x_push] = @area1[row_box][@x_push],@area1[row_player][@x]
    end
end