def process(lines)
ranges = []
lines.each do |l|
	start, finish = l.split("-").map{|n|n.to_i}
	ranges << [start, finish]
end
ranges.sort_by!{|r|r[0]}

range = [0,0]

puts ranges.map{|r|"#{r[0]} - #{r[1]}"}.join("\n")
ranges.each do |r|
	if (r[0] >= range[0] && r[0] <= (range[1] + 1) )
		if (r[1] > range[1])
			range[1] = r[1]
		end	
	end
end

puts range[1] + 1

end



test_input = "5-8
0-2
4-7"

process(test_input.split("\n"))
process(File.new("day20_input.txt").readlines)