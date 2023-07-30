# frozen_string_literal: true

module Module_move
  def move_right
    return @x unless @x < 570
    @x += @x_speed
  end

  def move_left
    return @x unless @x.positive?
    @x -= @x_speed
  end

  def move_top
    return @y unless @y.positive?
    @y -= @y_speed
  end

  def move_down
    return @y unless @y < 415
    @y += @y_speed
  end

  def right_collision_player(key_class)
    key_class.each do |key|
      if Gosu.distance(key['x'], key['y'], @x, @y) < 55
        if key['x'] < 570
          key['x'] += 7
          @x_test = key['x']
        else
          @x = key['x'] - 55
          return key['x']
        end
      end
    end
  end

  def right_collision_box(box_class)
      box_class.each do |box|
        if  @x_test >= box.x + box.w || 
            @x_test + box.w <= box.x || 
            @y_test >= box.y + box.h || 
            @y_test + box.h <= box.y
        then
          @x=0
        end
      end
  end

  def left_collision(key_class)
    key_class.each do |key|
      if Gosu.distance(key['x'], key['y'], @x, @y) < 55
        if (key['x']).positive?
          key['x'] -= 7
        else
          @x = key['x'] + 55
          return key['x']
        end
      end
    end
  end

  def up_collision(key_class)
    key_class.each do |key|
      if Gosu.distance(key['x'], key['y'], @x, @y) < 55
        if (key['y']).positive?
          key['y'] -= 7
        else
          @y = key['y'] + 55
          return key['y']
        end
      end
    end
  end

  def down_collision(key_class)
    key_class.each do |key|
      if Gosu.distance(key['x'], key['y'], @x, @y) < 55
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
