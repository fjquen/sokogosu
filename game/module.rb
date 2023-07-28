module Module_move
    def move_right
        if @x < 570
            @x += @x_speed
        else
            return @x
        end
    end

    def move_left
        if @x > 0
            @x -= @x_speed
        else
            return @x
        end
    end

    def move_top
        if @y > 0
            @y -= @y_speed
        else
            return @y
        end
    end

    def move_down
        if @y < 415
            @y += @y_speed
        else
            return @y
        end
    end

    def right_collision(key_class,cube_classe)
        key_class.keys.each do |key| 
            if Gosu.distance(key['x'],key['y'], @x, @y) < 55
                if key['x'] < 570
                    key['x'] += 7
                    cube_classe.cube_position['x'] += 7
                else
                    @x = key['x'] - 55
                    return key['x']
                end
            end
        end
    end
    
    def left_collision(key_class)
        key_class.keys.each do |key|
            if Gosu.distance(key['x'],key['y'], @x, @y) < 55
                if key['x'] > 0
                   key['x'] -= 7
                else
                  @x = key['x'] + 55
                  return key['x']
                end
            end
        end
    end

    def up_collision(key_class)
        key_class.keys.each do |key|
            if Gosu.distance(key['x'],key['y'], @x, @y) < 55
                if key['y'] > 0
                    key['y'] -= 7
                else
                    @y = key['y'] + 55
                    return key['y']
                end
            end
        end
    end
    
    def down_collision(key_class)
        key_class.keys.each do |key|
            if Gosu.distance(key['x'],key['y'], @x, @y) < 55
                if key['y'] < 415
                   key['y'] += 7
                else
                  @y = key['y'] - 55
                  return key['y']
                end
            end
        end
    end
end