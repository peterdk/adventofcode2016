

    def abas(input)
      results = []
      (0..(input.length - 3)).each do |i|
        current = input[i..(i+2)]
        results << current if (current[0] == current[2] && current[0] != current[1])
      end
      return results
    end

    def match(abas, babs)
      inverted = babs.map{|b|[b[1],b[0],b[1]].join}
      return (abas & inverted).length > 0
    end

    def valid(full_input)
      brackets = full_input.scan(/\[(\w+)/).flatten.compact
      non_brackets = full_input.scan(/(^|\])(\w+)/).map{|l|l[1]}.flatten.compact

      abas = non_brackets.map{|l|abas(l)}.flatten
      babs = brackets.map{|l|abas(l)}.flatten

      return (match(abas, babs))
    end

    def process(lines)
      valid_count = 0
      lines.each do |l|
        valid = valid(l)
        valid_count += 1 if valid
        puts "#{l}: #{valid}"
      end
      puts "Total valid: #{valid_count}"
    end

    test1 = "aba[bab]xyz"
    test2 = "xyx[xyx]xyx"
    test3 = "aaa[kek]eke"
    test4 = "zazbz[bzb]cdb"

    process([test1,test2,test3,test4])

    puts

     process(File.new("day7_input.txt").readlines.map{|l|l.strip})
