class Table
  attr_accessor :width, :height, :array

  def initialize(x, y)
    self.width = x
    self.height = y
    self.array = Array.new(height) { Array.new(width, '0') }
  end

  def new_object_position_on_table(x, y, direction)
    self.array = Array.new(height) { Array.new(width, '0') }
    array[height - 1 - y][x] = direction[0]
  end

  def show
    array.each do |arr|
      puts arr.join(' ')
    end
  end
end
