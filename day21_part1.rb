def swap_position(array, x, y)
  array[y], array[x] = array[x], array[y]
end

def swap_letters(array,x,y)
  array.map! do |l|
    if (l == x)
      y
    elsif (l == y)
      x
    else
      l
    end
  end
end


def rotate(array, left, count)
  array.rotate!(left ? count : (-count))
end

def rotate_based(array, letter)
  index = array.index(letter)
  rotations = index + 1
  rotations += 1 if index >= 4
  array.rotate!(-rotations)
end

def reverse_positions(array,x,y)
  reversed = array[x..y].reverse
  array[x..y] = reversed
end

def move(array, x, y)
  value = array.delete_at(x)
  array.insert(y,value)
end

def process(start, lines)
  array = start.chars.to_a
  lines.each do |l|
  #     puts array.join
  #     puts l

    if (l.match(/swap position (\d+) with position (\d+)/))
      swap_position(array, $1.to_i, $2.to_i)
      next
    elsif (l.match(/swap letter (\w+) with letter (\w+)/))
      swap_letters(array, $1, $2)
      next
    elsif (l.match(/rotate (left|right) (\d+) step/))
      left = $1 == "left"
      rotate(array, left, $2.to_i)
      next
    elsif (l.match(/rotate based on position of letter (\w+)/))
      rotate_based(array, $1)
      next
    elsif (l.match(/reverse positions (\d+) through (\d+)/))
      reverse_positions(array,$1.to_i, $2.to_i)
      next
    elsif (l.match(/move position (\d+) to position (\d+)/))
      move(array, $1.to_i, $2.to_i)
      next
    else
      raise l
    end
  end
  puts array.join
end

test = "swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d"

process("abcde", test.split("\n"))
process("abcdefgh", File.new("day21_input.txt").readlines)
