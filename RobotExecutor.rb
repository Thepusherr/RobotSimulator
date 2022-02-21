require_relative "robot"

class RobotExecutor
  def initialize
    @robot = Robot.new
    puts "directions: NORTH EAST SOUTH WEST"
    puts "x,y - numbers"
    puts "Enter commands(PLACE x,y,direction; MOVE; LEFT; RIGHT; REPORT): "
    @robot.input
  end
end

RobotExecutor.new