class Robot
  def initialize

  end

  private

  @current_angle = 0
  @position_on_table = [0,0]
  @current_direction = ""
  @direction_list = %w[NORTH SOUTH EAST WEST]

  def set_position_on_table

  end

  def change_angle()
    @current_angle += 90
  end

  def set_commands

  end

  def report
    puts "#{@position_on_table} #{@current_direction}"
  end
end
