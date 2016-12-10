def read(input)
  count = 0
  left = input
  start = left.index("(")
  if (!start || start < 0)
    return left.length
  end
  count += start
  left = left[start..-1]
  amount, times = left.match(/\((\d+)x(\d+)\)/).captures
  ending = left.index(")")
  count += (amount.to_i * times.to_i)
  left = left[(ending+amount.to_i+1)..-1]
  count += read(left)
end

def process(items)
  items.each do |i|
    puts i
    puts read(i)
  end
end

#puts read("peter(2x3)peter(2x5)rararar")

items = ["ADVENT", "A(1x5)BC","(3x3)XYZ","A(2x2)BCD(2x2)EFG","(6x1)(1x3)A","X(8x2)(3x3)ABCY"]
process(items)

puts read(File.new("day9_input.txt").read.strip)
