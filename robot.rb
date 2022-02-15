require_relative "table"

class Robot
  attr_accessor :table, :height, :array, :direction_list

  def initialize
    self.table = Table.new(5,6)
    self.direction_list = %w"NORTH SOUTH EAST WEST"
    place(1,3,"NORTH")
    self.table.show
    report
    move
    self.table.show
    report
    puts "WTF"

  end

  private

  @current_direction = ""
  @current_direction_index = 0
  @current_angle = 0
  @current_x_position = 0
  @current_y_position = 0


  def place(x,y,direction)
    return unless x < self.table.width && y < self.table.height
    @current_x_position = x
    @current_y_position = y
    @current_direction = direction
    self.table.array[x][self.table.height-2-y] = direction[0]
  end

  def change_angle()
    @current_angle += 90
  end

  def left

  end

  def right

  end

  # NORTH SOUTH EAST WEST
  def move
    if @current_direction == self.direction_list[0]
      @current_x_position -= 1
      self.table.array[@current_x_position][@current_y_position] = @current_direction[0]
    end
    if @current_direction == self.direction_list[1]
      @current_y_position -= 1
    end
    if @current_direction == self.direction_list[2]
      @current_y_position += 1
    end
    if @current_direction == self.direction_list[3]
      @current_y_position -= 1
    end
  end

  def report
    puts "Output: (#{@current_x_position},#{@current_y_position}), #{@current_direction}"
  end
end
Robot.new