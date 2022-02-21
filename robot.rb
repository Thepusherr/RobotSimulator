require_relative "table"

class Robot
  attr_accessor :table, :direction_list

  def initialize
    self.table = Table.new(5,6)
    self.direction_list = %w"NORTH EAST SOUTH WEST"
    direction_list.index("NORTH")
  end

  def input
    loop do
    command = gets.chomp
    if is_place?(command)
      args = command.split(" ")[1]
      args_array = args.split(',')
      x = args_array[0].to_i
      y = args_array[1].to_i
      direction = args_array[2]
      if is_args_correct?(x,y,direction)
        place(x,y,direction)
      end
    end
    return if @place_called
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

  @current_direction = ""
  @current_direction_index = 0
  @current_angle = 0
  @current_x_position = 0
  @current_y_position = 0
  @place_called = false

  def is_place?(command)
    command.split(" ")[1] && command[0...6] == "PLACE "
  end

  def place(x,y,direction)
    return unless x < self.table.width && y < self.table.height
    @current_x_position = x
    @current_y_position = y
    @current_direction = direction
    @place_called = true
    #self.table.array[self.table.height - x - 1][y] = direction[0]
  end

  def is_args_correct? (x,y,direction)
    x < self.table.width.to_i && x >= 0 && y < self.table.height.to_i && y >= 0 &&
      self.direction_list.include?(direction)
  end

  def left
    @current_direction = self.direction_list[self.direction_list.index(@current_direction)+1]

    i = 0
    while i < self.direction_list.length()
      if @current_direction == self.direction_list[i]
        new_pos = i - 1
        if new_pos >= 0
          return @current_direction = self.direction_list[new_pos]
        else
          return @current_direction = self.direction_list[direction_list.length() - 1]
        end
      end
      i += 1
    end
  end

  def right
    i = 0
    while i < self.direction_list.length()
      if @current_direction == self.direction_list[i]
        new_pos = i + 1
        if new_pos < direction_list.length()
          return @current_direction = self.direction_list[i+1]
        else
          return @current_direction = self.direction_list[0]
        end
      end
      i += 1
    end
  end

  # NORTH SOUTH EAST WEST
  def move
    if @current_direction == self.direction_list[0] && @current_x_position < self.table.width
      @current_x_position += 1
      #self.table.array[@current_x_position][@current_y_position] = @current_direction[0]
    end
    if @current_direction == self.direction_list[1] && @current_y_position < self.table.height
      @current_y_position += 1
    end
    if @current_direction == self.direction_list[2] && @current_x_position > 0
      @current_x_position -= 1
    end
    if @current_direction == self.direction_list[3] && @current_y_position > 0
      @current_y_position -= 1
    end
  end

  def report
    puts "Output: (#{@current_x_position},#{@current_y_position}), #{@current_direction}"
  end
end