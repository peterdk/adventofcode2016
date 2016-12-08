class Screen

  def initialize(width, height)
    @array = []
    height.times do |l|
      line = [false] * width
      @array << line
    end
  end

  def rect(width, height)
    (0...height).each do |h|
      (0...width).each do |w|
        @array[h][w] = true
      end
    end
  end

  def rotate_column(x, by)
    transposed = @array.transpose
    transposed[x].rotate!(-by)
    @array = transposed.transpose
  end

  def rotate_row(y, by)
    @array[y].rotate!(-by)
  end

  def values
    @array.flatten
  end

  def to_s
    @array.length.times do |y|
      puts @array[y].map{|v|v ? "#" : "."}.join
    end
  end
end

class Processor

  attr_reader :screen

  def initialize(width, height)
    @screen = Screen.new(width,height)
  end

  def process_command(command)
    m = command.match(/rect (\d+)x(\d+)/)
    if (m)
      @screen.rect(m[1].to_i, m[2].to_i)
      return
    end
    m = command.match(/rotate column x=(\d+) by (\d+)/)
    if (m)
      @screen.rotate_column(m[1].to_i, m[2].to_i)
      return
    end
    m = command.match(/rotate row y=(\d+) by (\d+)/)
    if (m)
      @screen.rotate_row(m[1].to_i, m[2].to_i)
      return
    end

  end

  def lit
    @screen.values.count{|v|v}
  end

  def to_s
    @screen.to_s
  end

end

p = Processor.new(7,3)
p.process_command("rect 3x2")
puts p
p.process_command("rotate column x=1 by 1")
puts p
p.process_command("rotate row y=0 by 4")
puts p
p.process_command("rotate column x=1 by 1")
puts p
puts

p = Processor.new(50,6)
File.new("day8_input.txt").readlines.map{|l|l.strip}.each do |l|
  p.process_command(l)
end
puts p.lit
