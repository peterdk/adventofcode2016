class Position
  attr_accessor :x, :y

  def initialize
    @x = 0
    @y = 0
  end

  def move(x, y)
    @x += x
    @y += y
  end

end


class Grid

  attr_accessor :position, :orientation

  def initialize
      @position = Position.new
      @orientation = 0
  end

  def process(instructions)
    data = instructions.split(",").map{|i|i.strip}
    data.each do |i|
      process_instruction(i)
    end
    blocks = @position.x.abs + @position.y.abs
    puts "blocks: #{blocks}"
  end

  def process_instruction(instruction)
    degrees = instruction.chars.first == 'L' ? -90 : 90
    turn(degrees)
    distance = instruction.chars.drop(1).join.to_i
    move(distance)
  end


  def turn(degrees)
    @orientation += degrees
    @orientation %= 360
  end

  def move(distance)
    if (@orientation == 0)
        @position.move(0,distance)
    elsif (@orientation == 90)
      @position.move(distance, 0)
    elsif (@orientation == 180)
      @position.move(0,-distance)
    elsif (@orientation == 270)
      @position.move(-distance,0)
    end
  end
end

input1 = "R2, L3"
input2 = "R2, R2, R2"
input3 = "R5, L5, R5, R3"

Grid.new.process(input1)
Grid.new.process(input2)
Grid.new.process(input3)

real_input ="L4, L1, R4, R1, R1, L3, R5, L5, L2, L3, R2, R1, L4, R5, R4, L2, R1, R3, L5, R1, L3, L2, R5, L4, L5, R1, R2, L1, R5, L3, R2, R2, L1, R5, R2, L1, L1, R2, L1, R1, L2, L2, R4, R3, R2, L3, L188, L3, R2, R54, R1, R1, L2, L4, L3, L2, R3, L1, L1, R3, R5, L1, R5, L1, L1, R2, R4, R4, L5, L4, L1, R2, R4, R5, L2, L3, R5, L5, R1, R5, L2, R4, L2, L1, R4, R3, R4, L4, R3, L4, R78, R2, L3, R188, R2, R3, L2, R2, R3, R1, R5, R1, L1, L1, R4, R2, R1, R5, L1, R4, L4, R2, R5, L2, L5, R4, L3, L2, R1, R1, L5, L4, R1, L5, L1, L5, L1, L4, L3, L5, R4, R5, R2, L5, R5, R5, R4, R2, L1, L2, R3, R5, R5, R5, L2, L1, R4, R3, R1, L4, L2, L3, R2, L3, L5, L2, L2, L1, L2, R5, L2, L2, L3, L1, R1, L4, R2, L4, R3, R5, R3, R4, R1, R5, L3, L5, L5, L3, L2, L1, R3, L4, R3, R2, L1, R3, R1, L2, R4, L3, L3, L3, L1, L2"
Grid.new.process(real_input)
