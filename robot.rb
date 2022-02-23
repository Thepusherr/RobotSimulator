# frozen_string_literal: true

require_relative 'table'

class Robot
  attr_accessor :table, :direction_list, :current_x_position, :current_y_position, :current_direction

  def initialize
    self.table = Table.new(5, 6)
    self.direction_list = %w[NORTH EAST SOUTH WEST]
  end

  def input
    loop do
      command = gets.chomp
      if command[0...6] == 'PLACE ' && command.split(' ')[1]
        args = command.split(' ')[1]
        args_array = args.split(',')
        next if args_array.size != 3

        x = args_array[0].to_i
        y = args_array[1].to_i
        direction = args_array[2]
        place(x, y, direction) if args_correct?(x, y, direction)
      end
      next unless @place_called

      move if command == 'MOVE'
      left if command == 'LEFT'
      right if command == 'RIGHT'
      report if command == 'REPORT'
    end
  end

  private

  @place_called = false

  def place(x, y, direction)
    return unless x < table.width && y < table.height

    self.current_x_position = x
    self.current_y_position = y
    self.current_direction = direction
    table.new_object_position_on_table(x, y, direction)
    @place_called = true
  end

  def args_correct?(x, y, direction)
    x < table.width.to_i && x >= 0 && y < table.height.to_i && y >= 0 &&
      direction_list.include?(direction)
  end

  def right
    next_left_direction = direction_list[direction_list.index(current_direction) + 1]
    self.current_direction = (!next_left_direction.nil? ? next_left_direction : direction_list[0])
  end

  def left
    next_left_direction = direction_list[direction_list.index(current_direction) - 1]
    !next_left_direction.nil? ? self.current_direction = next_left_direction : self.current_direction = direction_list[direction_list.size]
  end

  # NORTH SOUTH EAST WEST
  def move
    if current_direction == direction_list[0] && current_x_position + 1 < table.width
      self.current_x_position += 1
      table.new_object_position_on_table(self.current_x_position, current_y_position, current_direction)
    end
    if current_direction == direction_list[1] && current_y_position + 1 < table.height
      self.current_y_position += 1
      table.new_object_position_on_table(self.current_x_position, self.current_y_position, current_direction)
    end
    if current_direction == direction_list[2] && self.current_x_position.positive?
      self.current_x_position -= 1
      table.new_object_position_on_table(self.current_x_position, self.current_y_position, current_direction)
    end
    if current_direction == direction_list[3] && self.current_y_position.positive?
      self.current_y_position -= 1
      table.new_object_position_on_table(self.current_x_position, self.current_y_position, current_direction)
    end
  end

  def report
    table.show
    puts "Output: (#{@current_x_position},#{@current_y_position}), #{@current_direction}"
  end
end
