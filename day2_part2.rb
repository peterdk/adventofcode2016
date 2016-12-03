class Lock

  def initialize
    @numbers = [[:x,:x,:x,:x,:x,:x,:x],[:x,:x,:x,1,:x,:x,:x],[:x,:x,2,3,4,:x,:x],[:x,5,6,7,8,9,:x],[:x,:x,"A","B","C",:x,:x],
    [:x,:x,:x,"D",:x,:x,:x],[:x,:x,:x,:x,:x,:x,:x]]
    @x = 1 #we start at 5, not center
    @y = 3
  end

  def move(direction)
    move_y(-1) if (direction == :up)
    move_y(1) if (direction == :down)
    move_x(1) if (direction == :right)
    move_x(-1) if (direction == :left)
  end

  def move_y(amount)
    new_y = @y + amount
    number = number(@x, new_y)
    if (number != :x)
      @y = new_y
    end
  end

  def move_x(amount)
    new_x = @x + amount
    number = number(new_x, @y)
    if (number != :x)
      @x = new_x
    end
  end

  def current_number
    number(@x,@y)
  end

  def number(x,y)
    @numbers[y][x]
  end
end

class Processor

def initialize
  @lock = Lock.new
end

  def process(input)
    lines =  input.split("\n")
    lines.each do |l|
      l.split("").each do |d|
        direction = nil
        if (d == "U")
          direction = :up
        elsif ( d == "D")
          direction = :down
        elsif (d == "L")
          direction = :left
        elsif (d == "R")
          direction = :right
        end
        @lock.move(direction)
      end
      print @lock.current_number
    end
    puts

  end

end

test_input="ULL
RRDDD
LURDL
UUUUD"

full_input = "ULUULLUULUUUUDURUUULLDLDDRDRDULULRULLRLULRUDRRLDDLRULLLDRDRRDDLLLLDURUURDUDUUURDRLRLLURUDRDULURRUDLRDRRLLRDULLDURURLLLULLRLUDDLRRURRLDULRDDULDLRLURDUDRLLRUDDRLRDLLDDUURLRUDDURRLRURLDDDURRDLLDUUDLLLDUDURLUDURLRDLURURRLRLDDRURRLRRDURLURURRRULRRDLDDDDLLRDLDDDRDDRLUUDDLDUURUULDLUULUURRDRLDDDULRRRRULULLRLLDDUDRLRRLLLLLDRULURLLDULULLUULDDRURUDULDRDRRURLDRDDLULRDDRDLRLUDLLLDUDULUUUUDRDRURDDULLRDRLRRURLRDLRRRRUDDLRDDUDLDLUUDLDDRRRDRLLRLUURUDRUUULUDDDLDUULULLRUDULULLLDRLDDLLUUDRDDDDRUDURDRRUUDDLRRRRURLURLD
LDLUDDLLDDRLLDLDRDDDDDUURUDDDUURLRLRLDULLLDLUDDDULLDUDLRUUDDLUULLDRLDDUDLUDDLURRRLDUURDDRULLURLLRLLUUDRLDDDLDLDRDUDLRDURULDLDRRDRLDLUURRRRLUDDULDULUUUDULDDRLLDDRRUULURRUURRLDUUUDDDDRUURUDRRRDDDDLRLURRRRUUDDDULRRURRDLULRURDDRDRLUDLURDDRDURRUURDUDUDRRDDURRRDURDLUUUURRUDULLDDRLLLURLDUDRRLDDLULUDUDDDDUDLUUULUURUDRURUUDUUURRLDUUDRDRURLLDLLLLLRLLUDURDRRLULRRDDDRLDRDDURLRDULULLDDURURLRRDRULDULUUUURLDURUDUDUDDLUDRRDURULRDULLLDRRDLDLUDURDULULLDDURDDUDRUUUDUDRLDUURDUUUDUURURUDRULRURLDLRDDURDLUU
DDLDRLLDRRDRRLLUUURDDULRDUDRDRUDULURLLDDLRRRUDRDLDLURRRULUDRDLULLULLDUUDRLRUDDLRRURRUULRLDLLLDLRLLLURLLLURLLRDDLULLDUURLURDLLDLDUDLDRUUUDDLLDRRRRRUDRURUURRRDRUURDRDDRLDUUULUDUDRUDLLLLDRDRURRRDUUURLDLRLRDDDRLUDULDRLLULRDLDURDLDURUUDDULLULRDDRLRUURLLLURDRUURUUDUUULRDUDDRDURRRDUUDRRRUDRDLRURDLLDDDURLLRRDDDDLDULULDRLDRULDDLRRRLUDLLLLUDURRRUURUUULRRLDUURDLURRLRLLRDLRDDRDDLRDLULRUUUDDDUDRRURDDURURDDUDLURUUURUUUUDURDDLDRDULDRLDRLLRLRRRLDRLLDDRDLDLUDDLUDLULDLLDRDLLRDULDUDDULRRRUUDULDULRRURLRDRUDLDUDLURRRDDULRDDRULDLUUDDLRDUURDRDR
URDURRRRUURULDLRUUDURDLLDUULULDURUDULLUDULRUDUUURLDRRULRRLLRDUURDDDLRDDRULUUURRRRDLLDLRLRULDLRRRRUDULDDURDLDUUULDURLLUDLURULLURRRDRLLDRRDULUDDURLDULLDURLUDUULRRLLURURLDLLLURDUDRLDDDRDULLUDDRLDDRRRLDULLLLDUURULUDDDURUULUUUDURUDURDURULLLDRULULDRRLDRLDLRLRUDUDURRLURLRUUDRRDULULDLLDRDRRRDUDUURLDULLLURRDLUDDLDDRDDUDLDDRRRUDRULLURDDULRLDUDDDRULURLLUDLLRLRRDRDRRURUUUURDLUURRDULLRDLDLRDDRDRLLLRRDDLDDDDLUDLRLULRRDDRDLDLUUUDLDURURLULLLDDDULURLRRURLDDRDDLD
UDUULLRLUDLLUULRURRUUDDLLLDUURRURURDDRDLRRURLLRURLDDDRRDDUDRLLDRRUDRDRDDRURLULDDLDLRRUDDULLRLDDLRURLUURUURURDLDUDRLUUURRRLUURUDUDUUDDLDULUULRLDLLURLDRUDRLLRULURDLDDLLULLDRRUUDDLRRRUDDLRDRRRULDRDDRRULLLUDRUULURDUDRDLRRLDLRLRLDDULRRLULUUDDULDUDDULRRURLRDRDURUDDDLLRLDRDRULDDLLRLLRDUDDDDDDRLRLLDURUULDUUUDRURRLLRLDDDDRDRDUURRURDRDLLLUDDRDRRRDLUDLUUDRULURDLLLLLRDUDLLRULUULRLULRURULRLRRULUURLUDLDLLUURDLLULLLDDLRUDDRULRDLULRUURLDRULRRLULRLRULRDLURLLRURULRDRDLRRLRRDRUUURURULLLDDUURLDUDLLRRLRLRULLDUUUULDDUUU"
p = Processor.new.process(test_input)
p = Processor.new.process(full_input)