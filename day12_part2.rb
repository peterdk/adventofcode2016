
$registers = {:a => 0, :b => 0, :c => 1, :d => 0}

class Instruction

  def initialize(type, value1, value2 = nil)
    @type = type
    @value1 = value1.match(/[a-d]/) ? value1.to_sym : value1.to_i
    @value2 = (value2.match(/[a-d]/) ? value2.to_sym : value2.to_i) if value2 != nil
    @register_values = $registers.keys
  end

  def process
    if (@type == :cpy)
      $registers[@value2] = value(@value1)
    elsif (@type == :inc)
      $registers[@value1] += 1
    elsif (@type == :dec)
      $registers[@value1] -= 1
    elsif (@type == :jnz)
      if (value(@value1) != 0)
        return @value2
      end
    end
    return 1
  end

  def value(input)
    case input
      when Symbol
        $registers[input]
      else
        input
      end
  end

end

class Processor

  attr_reader :instructions

def parse(lines)
@instructions = []
lines.each do |instr|
  if (instr.match(/cpy ([0-9a-d]+) ([a-d])/))
    @instructions << Instruction.new(:cpy, $1, $2)
  elsif(instr.match(/inc ([a-d])/))
    @instructions << Instruction.new(:inc, $1)
  elsif(instr.match(/dec ([a-d])/))
    @instructions << Instruction.new(:dec, $1)
  elsif(instr.match(/jnz ([0-9a-d]+) (-*[0-9]+)/) )
    @instructions << Instruction.new(:jnz, $1, $2)
  end
end
end

def process
  current_index = 0
  while (current_index < @instructions.length)
    instr = @instructions[current_index]
    current_index += instr.process
  end
  puts "Finished processing, value in 'a' => #{$registers[:a]}"
end

end

test = "cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a"
p = Processor.new
p.parse(test.split("\n"))
p.process
p = Processor.new
p.parse(File.new("day12_input.txt").readlines.map{|l|l.strip})
p.process
