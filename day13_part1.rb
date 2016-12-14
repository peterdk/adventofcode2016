
def open(x,y)
  value = (x*x + 3*x + 2*x*y + y + y*y)
  value += $fav
  bits = value.to_s(2)
  sum = bits.chars.to_a.count{|b|b == "1"}
  open = ((sum % 2 ) == 0)
  open
end

def draw
  maze = Array.new(10){Array.new(10, nil)}
  (0..9).each do |y|
    (0..9).each do |x|
      maze[y][x] = open(x,y)
    end
  end
  maze.each_with_index do |row,i|
    puts row.map{|v| v == true ? ".":"x"}.join
  end
end

def solve(x,y)
  reach(x,y,[[[1,1]]])
end

def reach(x,y, current)
  next_iter = []
  current.each do |p|
    last_pos = p.last
    options = next_options(last_pos[0],last_pos[1])
    valid = options.select{|c|!p.include?(c)}
    valid.each do |o|
      dup = p.dup
      dup << o
      next_iter << dup
      if o[0] == x && o[1] == y
        puts "Reached #{x},#{y} in #{dup.count - 1} steps"
        return
      end
    end
  end
  #puts next_iter.inspect
  reach(x,y,next_iter)
end



def next_options(x,y)
  directions = [[x+1,y], [x-1,y], [x,y+1],[x,y-1]]
  directions.select{|c|open(c[0],c[1])}
end

$fav = 10
draw
solve(7,4)

$fav = 1362
solve(31,39)
