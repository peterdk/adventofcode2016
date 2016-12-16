def fill(input)
  a = input
  b = input
  b = b.chars.to_a.reverse.map{|c| c == '1' ? '0' : '1'}
  return "#{a}0#{b.join}"
end

def generate(input, length)
  data = input
  while (data.length < length)
    data = fill(data)
    puts data.length
  end
  data = data[0...length]
  checksum = checksum(data)
  while (checksum.length % 2 == 0)
    checksum = checksum(checksum)
  end
  checksum
end

def checksum(data)
  data.chars.each_slice(2).map{|p|p[0] == p[1] ? "1":"0"}.join
end

puts generate("110010110100", 12)
puts generate("10000", 20)
puts generate("01000100010010111", 272)
puts generate("01000100010010111", 35651584)
