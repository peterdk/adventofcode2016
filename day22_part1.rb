#1419 - #1428 = 9 minutes = +- #60
class Node

  attr_accessor :name, :size, :used, :avail, :use

  def initialize(name, size, used, avail, use)
    @name = name
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
  puts nodes.permutation(2).count{|(a,b)| a.used != 0 && a.used <= b.avail}
end

process(File.new("day22_input.txt").readlines.drop(2))
