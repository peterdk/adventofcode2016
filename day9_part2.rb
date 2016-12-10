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
  decompress = left[(ending+1)..(ending+amount.to_i)]
  count += ((times.to_i)* read(decompress))
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

items = ["(3x3)XYZ","X(8x2)(3x3)ABCY","(27x12)(20x12)(13x14)(7x10)(1x12)A","(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"]
process(items)

puts read(File.new("day9_input.txt").read.strip)
