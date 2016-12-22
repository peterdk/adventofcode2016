#1419 - #1428 = 9 minutes = +- #60
class Node

  attr_accessor :name, :size, :used, :avail, :use, :x, :y

  def initialize(name, size, used, avail, use)
    @name = name
    name.match(/node-x(\d+)-y(\d+)/)
    @x = $1.to_i
    @y = $2.to_i
    @size = size
    @used = used
    @avail = avail
    @use = use
  end

  def self.parse(line)
    puts line.strip
    name, size, used, avail, use = line.strip.split(/\s+/)
    Node.new(name, size.gsub("T", "").to_i, used.gsub("T","").to_i, avail.gsub("T","").to_i, use.gsub("%","").to_i)
  end
end

def process(lines)
  nodes = lines.map{|l|Node.parse(l)}
  # nodes.each {|n|puts [n.x,n.y].join(",")}
  moveable = nodes.permutation(2).select{|(a,b)| a.used != 0 && a.used <= b.avail}.flatten.select{|n|n.used != 0}
  free = nodes.find{|n|n.used == 0}
  barrier = nodes.select{|n|n.used != 0 && !moveable.include?(n)}
  max_x = nodes.sort_by{|n|n.x}.last.x
  max_y= nodes.sort_by{|n|n.y}.last.y
  grid = Array.new(max_y+1){Array.new(max_x+1, nil)}
  puts max_x
  puts max_y
  nodes.each do |node|
    grid[node.y][node.x] = node
  end

  grid.map!{|row| row.map do |node|
    if moveable.include?(node)
      "."
    elsif barrier.include?(node)
      "#"
    elsif free == node
      "_"
    else
      "?"
    end
  end
  }
  puts grid.map{|row|row.join}.join("\n")

  #manual solve
end

process(File.new("day22_input.txt").readlines.drop(2))
