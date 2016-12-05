require 'digest/md5'

def generate(door_id)
start = Time.now
prefix = "0" * 5
puts "generating password"
current = 0
found = 0
pass = ["-","-","-","-","-","-","-","-"]
while (found < 8)
  input = "#{door_id}#{current}"
  md5 = Digest::MD5.hexdigest(input)
  if (md5.start_with?(prefix))
    chars = md5.chars.to_a
    position = chars[5].to_s
    if (position.match(/[0-7]/))
        if (pass[position.to_i] == "-")
          value = chars[6]
          pass[position.to_i] = value
          found += 1
          puts pass.join
        end
      end
  end
  current += 1
end
puts "#{current} iterations in #{Time.now-start} seconds needed"
end

#test_id = "abc"
#generate(test_id)

id = "ffykfhsq"
generate(id)
