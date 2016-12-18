


class Disc

  attr_accessor :number, :positions, :start

  def initialize(number, positions, start)
    @number = number
    @positions = positions
    @start = start
  end

  def initial_rotations
    first = (@start + @number) % @positions
    if (first > 0)
      return @positions - first
    end
    return 0
  end



end

d1 = Disc.new(1, 5, 4)
d2 = Disc.new(2,2,1)
puts d1.initial_rotations
puts d2.initial_rotations

def calculate(discs)
  #get everything at 0

end

test = "Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1."


input = "Disc #1 has 7 positions; at time=0, it is at position 0.
Disc #2 has 13 positions; at time=0, it is at position 0.
Disc #3 has 3 positions; at time=0, it is at position 2.
Disc #4 has 5 positions; at time=0, it is at position 2.
Disc #5 has 17 positions; at time=0, it is at position 0.
Disc #6 has 19 positions; at time=0, it is at position 7."
