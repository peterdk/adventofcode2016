def fill(input)
  a = input
  b = input
  b = b.reverse.map{|c| c != true}
  return a + [false] + b
end

def generate(input, length)
  data = input.chars.map{|i|i == "1"}
  while (data.length < length)
    data = fill(data)
    puts "#{data.length} => #{(data.length.to_f / length) * 100}"
  end
  data = data[0...length]
  checksum = checksum(data)
  while (checksum.length % 2 == 0)
    puts "checksum length: #{checksum.length}"
    checksum = checksum(checksum)
  end
  checksum.map{|c|c ? "1": "0"}.join
end

def checksum(data)
  data.each_slice(2).map{|(a,b)| a == b}
end

#puts generate("110010110100", 12)
#puts generate("1010", 20)
#generate("10100", 200)

#puts generate("01000100010010111", 272)
puts generate("01000100010010111", 35651584)
