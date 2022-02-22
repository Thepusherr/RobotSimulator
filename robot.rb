require_relative "table"

class Robot
  attr_accessor :table, :direction_list, :current_x_position, :current_y_position, :current_direction

  def initialize
    self.table = Table.new(5, 6)
    self.direction_list = %w"NORTH EAST SOUTH WEST"
  end

  def input
    loop do
      command = gets.chomp
      if command[0...6] == "PLACE " && command.split(" ")[1]
        args = command.split(" ")[1]
        args_array = args.split(',')
        next if args_array.size != 3
        x = args_array[0].to_i
        y = args_array[1].to_i
        direction = args_array[2]
        if is_args_correct?(x, y, direction)
          place(x, y, direction)
        end
      end
      next unless @place_called
      if command == "MOVE"
        move
      end
      if command == "LEFT"
        left
      end
      if command == "RIGHT"
        right
      end
      if command == "REPORT"
        report
      end
    end
  end

  private

  @place_called = false

  def place(x, y, direction)
    return unless x < self.table.width && y < self.table.height
    self.current_x_position = x
    self.current_y_position = y
    self.current_direction = direction
    self.table.new_object_position_on_table(x, y, direction)
    @place_called = true
  end

  def is_args_correct? (x, y, direction)
    x < self.table.width.to_i && x >= 0 && y < self.table.height.to_i && y >= 0 &&
      self.direction_list.include?(direction)
  end

  def right
    next_left_direction = self.direction_list[self.direction_list.index(self.current_direction) + 1]
    next_left_direction != nil ? self.current_direction = next_left_direction : self.current_direction = direction_list[0]
  end

  def left
    next_left_direction = self.direction_list[self.direction_list.index(self.current_direction) - 1]
    next_left_direction != nil ? self.current_direction = next_left_direction : self.current_direction = direction_list[self.direction_list.size]
  end

  # NORTH SOUTH EAST WEST
  def move
    if self.current_direction == self.direction_list[0] && self.current_x_position + 1 < self.table.width
      self.current_x_position += 1
      self.table.new_object_position_on_table(self.current_x_position, self.current_y_position, self.current_direction)
    end
    if self.current_direction == self.direction_list[1] && self.current_y_position + 1 < self.table.height
      self.current_y_position += 1
      self.table.new_object_position_on_table(self.current_x_position, self.current_y_position, self.current_direction)
    end
    if self.current_direction == self.direction_list[2] && self.current_x_position > 0
      self.current_x_position -= 1
      self.table.new_object_position_on_table(self.current_x_position, self.current_y_position, self.current_direction)
    end
    if self.current_direction == self.direction_list[3] && self.current_y_position > 0
      self.current_y_position -= 1
      self.table.new_object_position_on_table(self.current_x_position, self.current_y_position, self.current_direction)
    end
  end

  def report
    self.table.show
    puts "Output: (#{@current_x_position},#{@current_y_position}), #{@current_direction}"
  end
end