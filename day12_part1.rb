
$registers = {"a" => 0, "b" => 0, "c" => 0, "d" => 0}


def process(instructions)
  current_index = 0
  while (current_index < instructions.length)
    instr = instructions[current_index]
    if (instr.match(/cpy ([0-9a-d]+) ([a-d])/))
      $registers[$2] = value($1)
    elsif(instr.match(/inc ([a-d])/))
      $registers[$1] += 1
    elsif(instr.match(/dec ([a-d])/))
      $registers[$1] -= 1
    elsif(instr.match(/jnz ([0-9a-d]+) (-*[0-9]+)/) )
      if (value($1) != 0)
        current_index += $2.to_i
        #puts current_index
        next
      end
    else
      raise instr
    end
    current_index += 1
    #puts current_index
  end
  puts "Finished processing, value in 'a' => #{$registers['a']}"
end

def value(input)
  if (input.match(/[a-d]/))
    $registers[input]
  else
    input.to_i
  end
end

test = "cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a"
process(test.split("\n"))
process(File.new("day12_input.txt").readlines.map{|l|l.strip})
