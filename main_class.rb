require_relative "robot"

class MainClass
  def initialize
    @robot = Robot.new
    puts "directions: NORTH EAST SOUTH WEST"
    puts "x,y - numbers"
    puts "Enter commands(PLACE x,y,direction; MOVE; LEFT; RIGHT): "
    @robot.input
  end
end

MainClass.new