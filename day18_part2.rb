def process(start, row_count)
  rows = [start]
  while (rows.length < row_count)
    puts rows.length if rows.length % 100 == 0
    old_row = rows.last
    new_row = [false] * old_row.length
    new_row.each_with_index do |tile, i|
      left,center,right = get_tiles(old_row, i)
       trap = ((left && center && !right) || (center && right && !left) || (left && !center && !right) || (!left && !center && right))
       new_row[i] = trap
    end
    rows << new_row
  end
  puts rows.flatten.count{|r| !r}
end

def get_tiles(old_row, i)
  left = i > 0 ? old_row[i-1] : false
  center = old_row[i]
  right = (i < (old_row.length - 1)) ? old_row[i + 1] : false
  [left,center,right]
end

input =".^^.^.^^^^"
values = input.chars.map{|c|c =="^"}
process(values, 10)

 input = ".^^^^^.^^.^^^.^...^..^^.^.^..^^^^^^^^^^..^...^^.^..^^^^..^^^^...^.^.^^^^^^^^....^..^^^^^^.^^^.^^^.^^"
 values = input.chars.map{|c|c =="^"}
 process(values, 400000)
