class Position
  include Comparable
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    @x = x
    @y = y
  end

  def move(x, y)
    @x += x
    @y += y
  end

  def clone
    p = Position.new
    p.x = @x
    p.y = @y
    return p
  end

 def <=>(other)
   return 0 if @x == other.x && @y == other.y
   return -1
 end

 def eql?(other)
   return other == self
 end

 def hash
   return x * 31 + y
 end

def to_s
  "#{x},#{y}"
end

end

class Line

  def initialize(start, _end)
    @start = start
    @end = _end
  end

def points
  if (@start.x == @end.x)
    ys = []
    x = @start.x
    if (@start.y < @end.y)
      ys = (@start.y..@end.y).to_a.drop(1)
    else
      ys = (@end.y...@start.y).to_a
    end
    return ys.map{|y|Position.new(x,y)}
  elsif (@start.y == @end.y)
    xs = []
    y  = @start.y
    if (@start.x < @end.x)
      xs = (@start.x..@end.x).to_a.drop(1)
    else
      xs = (@end.x...@start.x).to_a
    end
    return xs.map{|x|Position.new(x,y)}
  end
end

  def intersect(other)
    other.points & self.points
  end
end

def to_s
  "#{@start} => #{@end}"
end

class Grid

  attr_accessor :position, :orientation

  def initialize
      @position = Position.new
      @orientation = 0
  end

  def process(instructions)
    positions = [Position.new]
    data = instructions.split(",").map{|i|i.strip}
    data.each do |i|
      process_instruction(i)
      positions << @position.clone
    end

    lines = []
    positions.each_with_index do |p,i|
      if (i > 0)
        l = Line.new(positions[i-1], p)
        if (l.points == nil || l.points.size == 0)
          puts "points empty!"
          puts l
        end
        lines << l
      end
    end
    intersect_pos = nil
    lines.each_with_index do |l,i|
      lines[0...i].each do |l2|
        intersections = l.intersect(l2)
        if (intersections != nil && intersections.size > 0)
          puts l
          puts l2
          puts intersections
          puts i
          intersect_pos = intersections[0]
          blocks_away(intersect_pos)
          return

        end
      end
    end


  end

  def blocks_away(position)
    blocks = position.x.abs + position.y.abs
    puts "blocks: #{blocks}"
    return blocks
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

input1 = "R8, R4, R4, R8"

Grid.new.process(input1)

real_input ="L4, L1, R4, R1, R1, L3, R5, L5, L2, L3, R2, R1, L4, R5, R4, L2, R1, R3, L5, R1, L3, L2, R5, L4, L5, R1, R2, L1, R5, L3, R2, R2, L1, R5, R2, L1, L1, R2, L1, R1, L2, L2, R4, R3, R2, L3, L188, L3, R2, R54, R1, R1, L2, L4, L3, L2, R3, L1, L1, R3, R5, L1, R5, L1, L1, R2, R4, R4, L5, L4, L1, R2, R4, R5, L2, L3, R5, L5, R1, R5, L2, R4, L2, L1, R4, R3, R4, L4, R3, L4, R78, R2, L3, R188, R2, R3, L2, R2, R3, R1, R5, R1, L1, L1, R4, R2, R1, R5, L1, R4, L4, R2, R5, L2, L5, R4, L3, L2, R1, R1, L5, L4, R1, L5, L1, L5, L1, L4, L3, L5, R4, R5, R2, L5, R5, R5, R4, R2, L1, L2, R3, R5, R5, R5, L2, L1, R4, R3, R1, L4, L2, L3, R2, L3, L5, L2, L2, L1, L2, R5, L2, L2, L3, L1, R1, L4, R2, L4, R3, R5, R3, R4, R1, R5, L3, L5, L5, L3, L2, L1, R3, L4, R3, R2, L1, R3, R1, L2, R4, L3, L3, L3, L1, L2"
Grid.new.process(real_input)
