require 'digest/md5'
$md5s = []
def keys(salt)

  keys = []
  index = 0
  while (keys.length != 64)
    md5 = md5(salt, index)
    if (md5.match(/([a-z0-9])\1{2}/))
      char = $1[0]
      (1..1000).each do |ni|
        fiver = md5(salt, index + ni)
        if (fiver.include?(char * 5))
          keys << md5
          puts "key #{keys.length} is hash #{index} => #{md5}"
          break
        end
      end
    end
    index += 1
  end
end

def md5(salt, index)
  existing = $md5s[index]
  if (!existing)
    input = "#{salt}#{index}"
    md5 = Digest::MD5.hexdigest(input)
    2016.times do |i|
      md5 = Digest::MD5.hexdigest(md5)
    end
    $md5s[index] = md5
    return md5
  end
  return existing
end

#keys("abc")
keys("cuanljph")
