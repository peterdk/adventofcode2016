def process(lines)
ranges = []
lines.each do |l|
	start, finish = l.split("-").map{|n|n.to_i}
	ranges << [start, finish]
end
ranges.sort_by!{|r|r[0]}

full_ranges = [[0,0]]

ranges.each do |r|
	new_ranges = []
	match = false	
	full_ranges.each do |range|
		if (r[0] >= range[0] && r[0] <= (range[1] + 1) )
			if (r[1] > range[1])
				range[1] = r[1]
			end																
			match = true
		end
	end		
	full_ranges << r if (!match)
	
	full_ranges.sort_by!{|r|r[0]}
	puts full_ranges.size		
end
#puts full_ranges.map{|r|"#{r[0]} - #{r[1]}"}.join("\n")

full_ranges.unshift([-1,-1])
full_ranges << [4294967295+1,4294967295+1]

(1...(full_ranges.length)).each do |i|
puts "#{full_ranges[i][0]} - #{(full_ranges[i-1][1] + 1)} = #{full_ranges[i][0] - (full_ranges[i-1][1] + 1)}"
end
puts (1...(full_ranges.length)).map{|i|full_ranges[i][0] - (full_ranges[i-1][1] + 1)}.inject(:+)
end



test_input = "5-8
0-2
4-7"

process(test_input.split("\n"))
process(File.new("day20_input.txt").readlines)