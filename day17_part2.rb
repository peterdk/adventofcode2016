require 'digest/md5'
class Route

  attr_accessor :x,:y,:steps

  def initialize(x,y)
    @x = x
    @y = y
    @steps = []
  end

  def move(x,y)
    if (x == @x)
      if (y > @y)
        @steps << "D"
      elsif (y < @y)
        @steps << "U"
      end
    elsif(y == @y)
      if (x > @x)
        @steps << "R"
      elsif (x < @x)
        @steps << "L"
      end
    end
    @x = x
    @y = y
  end

  def dup
    dup = Route.new(@x,@y)
    dup.steps = @steps.dup
    return dup
  end
end

def next_steps(route)
  #up down left right
  @up = [0,-1]
  @down = [0,1]
  @left = [-1,0]
  @right = [1,0]
  positions = [@up,@down, @left, @right].map{|(x,y)| [route.x + x, route.y + y]}
  hash = hash(route.steps.join)
  open = positions.each_with_index.select{|p,i| hash[i].match(/[b-f]/)}.map{|p,i|p}
  valid = open.select{|(x,y)|x >= 0 && x < 4 && y >= 0 && y < 4}
  return valid
end

def process
  puts $key
  solve(3,3,[Route.new(0,0)])
end

def solve(x,y, routes)
  reached = []
  while (routes.length > 0)
    next_routes = []
    routes.each do |route|
      next_steps = next_steps(route)
      next_steps.each do |step|
        dup = route.dup
        dup.move(step[0],step[1])
        if (step[0] == 3 && step[1] == 3)
          #puts "Reached 3,3 in #{dup.steps.length} steps"
          reached << dup
        else
          next_routes << dup
        end
      end
    end
    routes = next_routes
  end
  puts "Longest route: #{reached.last.steps.length}: #{reached.last.steps.join}"
end


def hash(path)
  Digest::MD5.hexdigest("#{$key}#{path}")
end

$key = "ihgpwlah"
process

$key = "kglvqrro"
process

$key = "ulqzkmiv"
process

$key = "ioramepc"
process
