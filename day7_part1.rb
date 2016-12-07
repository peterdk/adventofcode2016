

def has_abba(input)
  #puts input
  (0..(input.length - 4)).each do |i|
    current = input[i..(i+3)]
#    puts "current:#{current}"
    return true if (current[0] == current[3] && current[1] == current[2] && current[0] != current[1])
  end
  return false
end

def valid(full_input)

  brackets = full_input.scan(/\[(\w+)/).flatten.compact
  non_brackets = full_input.scan(/(^|\])(\w+)/).map{|l|l[1]}.flatten.compact

#  puts full_input
#  puts "brackets:#{brackets.join(',')}"
#  puts "non_brackets:#{non_brackets.join(',')}"

  valid = true
  if (!brackets.map{|b|has_abba(b)}.include?(true))
    return true if (non_brackets.map{|l|has_abba(l)}.include?(true))
  end
  return false
end

def process(lines)
  valid_count = 0
  lines.each do |l|
    valid = valid(l.strip)
    valid_count += 1 if valid
    puts "#{l.strip}: #{valid}"
  end
  puts "Total valid: #{valid_count}"
end

test1 = "abba[mnop]qrst"
test2 = "abcd[bddb]xyyx"
test3 = "aaaa[qwer]tyui"
test4 = "ioxxoj[asdfgh]zxcvbn"

process([test1,test2,test3,test4])

puts

 process(File.new("day7_input.txt").readlines.map{|l|l.strip})
