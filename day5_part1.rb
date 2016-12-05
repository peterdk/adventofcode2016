require 'digest/md5'

def generate(door_id)
  puts "generating password"
  current = 0

  pass = ""
  while (pass.length < 8)
    input = "#{door_id}#{current}"
    md5 = Digest::MD5.hexdigest(input)
    if (md5.match(/^00000/))
      pass += md5.chars.to_a[5].to_s
      puts pass
    end
    current += 1
  end
end

#test_id = "abc"
#generate(door_id)

id = "ffykfhsq"
generate(id)
