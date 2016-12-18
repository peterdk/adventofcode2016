#microchips fry if not with RTG when other RTG is there
#elevator requires 1 RTG or microchip to function



class ElementalItem
  attr_reader :element

  def initialize(element)
    @element = element
  end

  def compatible(item)
    @element == item.element
  end

  def dup
    ElementalItem.new(@element)
  end

  def ==(other)
    self.class == other.class && @element == other.element
  end


end

class Generator < ElementalItem

  def to_s
    "#{@element[0].upcase}#{@element[1]}G"
  end

  def inspect
    "#{@element} Generator"
  end
end

class MicroChip < ElementalItem

  def to_s
    "#{@element[0].upcase}#{@element[1]}M"
  end

  def inspect
    "#{@element} MicroChip"
  end


end


class Floor
  attr_accessor :items
  attr_reader :number

  def initialize(number, items)
    @number = number
    @items = items
  end

  def safe
    generators = @items.select{|i|i.class == Generator}
    chips = @items.select{|i|i.class == MicroChip}
    return true if (generators.length == 0)
    chips_without_generators = chips.select{|c| !generators.any?{|g|g.compatible(c)}}
    #generators_without_chips = generators.select{|g| !chips.any?{|c|c.compatible(g)}}
    return (chips.length == 0 || (chips.length > 0 && chips_without_generators.length == 0 ))
  end

  def dup
    Floor.new(@number, @items.dup)
  end

  def inspect
    "Floor #{@number}: #{@items.inspect}"
  end

  def to_s
    "F#{@number + 1} #{@items.sort_by{|c|c.to_s}.join('. ')}"
  end

end

class Building
  attr_accessor :floors, :position

  def initialize(position, floors)
    @position = position
    @floors = floors
  end

  def current_floor
    @floors[@position]
  end

  def dup
    floors = @floors.map{|f|f.dup}
    Building.new(@position, floors)
  end

  def finished
    @position == 3 && @floors[0..2].all?{|f|f.items.length == 0} && @floors.last.safe
  end

  def to_s
    @floors.reverse.map{|f|f.to_s + (f.number == @position ? ' * ': '') }.join("\n")
  end

  def ==(other)
    @position == other.position && (@floors.each_with_index.all?{|f,i|(other.floors[i].items - f.items).length == 0})
  end

  def to_generic_s
    floor_dict = {}
    @floors.map{|f|[f,f.items]}.each {|(f,items)| items.each {|i| floor_dict[i] = f.number}}
    generators = floor_dict.keys.select{|i| i.class == Generator}
    microchips = floor_dict.keys.select{|i|i.class == MicroChip}
    result = []
    generators.each do |g|
      chip = microchips.find{|c|c.compatible(g)}
      chip_floor = floor_dict[chip]
      generator_floor = floor_dict[g]
      result << "#{chip_floor}C#{generator_floor}G"
    end
    "#{result.sort.join}@#{@position}"
  end

end

class Route
  attr_accessor :states

  def initialize(states)
    @states = states
  end

  def dup
    Route.new(@states.dup)
  end

  def current
    @states.last
  end

  def not_duplicating
    @states.length < 4 || @states[0...@states.length - 1].all?{|s|@states.last != s}
    #(@states[-3] != @states[-1] && @states[-4] != @states[-2])
  end

  def solved
    @states.last.finished
  end

  def to_s
    state = @states.each_with_index{|r,i| "#{i}\n#{r.to_s}"}.join("\n\n")
    "Route: #{@states.length} steps\n#{state}\n"
  end
end

def next_states(route)
  #puts
  new_states = []
  building = route.current
  available_items = building.current_floor.items
  combinations = [1,2].map{|c| available_items.combination(c).to_a}.flatten(1)
  identical = combinations.select{|c| c.length == 2 && c[0].class == Generator && c[1].class == MicroChip && c[0].element == c[1].element}
  if identical.length > 1
     identical.drop(1).each do |c|
       combinations -= [c]
     end
 end
  #only existing floors
  directions = [building.position + 1, building.position - 1].select{|p| p >= 0 && p < 4}
  #don't go down when all the floors below are cleared
  directions = directions.select{|d|!(building.floors[0..d].all?{|f|f.items.length == 0})}
  #puts building.position
  #puts "directions = #{directions.size} (#{directions.join(",")})"
  #puts "combinations = #{combinations.size}"
  directions.each do |direction|
    combinations.each do |items|

      dup = route.current.dup
  #    puts "Current items on current floor (#{dup.current_floor.number}): #{dup.current_floor.items.inspect}"
  #    puts "Elevator Items: #{items.inspect}"

  #    puts "Current Items on next floor: #{dup.floors[direction].items.inspect}"
      dup.current_floor.items -= items
      dup.floors[direction].items += items
      if (dup.current_floor.safe)
        dup.position = direction
  #    puts "Safe: #{dup.current_floor.safe}: #{dup.current_floor.inspect}"
  #    puts
      if (dup.current_floor.safe)
        new_state = route.dup
        new_state.states << dup
        if (new_state.not_duplicating)
          new_states << new_state
        end
      end
    end
    end
  end
  return new_states
end


def solve(routes)
  while (routes.length > 0)
    next_routes = []
    routes.each do |route|
       new_routes= next_states(route)
       next_routes += new_routes
      new_routes.each do |r|
        #puts r.to_s
        if (r.solved)
          puts "Finished moving to 4th floor in #{r.states.length - 1}"
          #  puts r.to_s
          return
        end
      end
    end
    routes = next_routes.uniq{|r|r.current.to_s}.uniq{|r|r.current.to_generic_s}
    puts "#{routes.first.states.length - 1} steps => #{routes.length} routes (non uniq: #{next_routes.count - routes.count})"
    # if (routes.first.states.length == 4)
    #   puts routes.map{|r|r.to_s}
    #   return
    # end
  end
end

def process()
  solve([Route.new([])])
end

def process_debug
  hm = MicroChip.new("hydrogen")
  lm = MicroChip.new("lithium")
  hg = Generator.new("hydrogen")
  lg = Generator.new("lithium")

  f1 = Floor.new(0, [hm,lm])
  f2 = Floor.new(1, [hg])
  f3 = Floor.new(2, [lg])
  f4 = Floor.new(3, [])

  #puts f1.safe


  start = Building.new(0,[f1,f2,f3,f4])
  route = Route.new([start])
  #next_states(route)
  solve([route])

end

def process_real
  prg = Generator.new("promethium")
  prm = MicroChip.new("promethium")

  cog = Generator.new("cobalt")
  cug = Generator.new("curium")
  rug = Generator.new("ruthenium")
  plg = Generator.new("plutonium")

  com = MicroChip.new("cobalt")
  cum = MicroChip.new("curium")
  rum = MicroChip.new("ruthenium")
  plm = MicroChip.new("plutonium")

  elg = Generator.new("elerium")
  elm = MicroChip.new("elerium")
  dlg = Generator.new("dilithium")
  dlm = MicroChip.new("dilithium")

  f1 = Floor.new(0, [prg,prm, elg, elm, dlg, dlm])
  f2 = Floor.new(1, [cog, cug, rug, plg])
  f3 = Floor.new(2, [com,cum,rum,plm])
  f4 = Floor.new(3, [])

  #puts f1.safe


  start = Building.new(0,[f1,f2,f3,f4])
  route = Route.new([start])
  #next_states(route)
  solve([route])

end


def test
  hm = MicroChip.new("hydrogen")
  lm = MicroChip.new("lithium")
  hg = Generator.new("hydrogen")
  lg = Generator.new("lithium")

  f1 = Floor.new(0, [hm,lm])
  f2 = Floor.new(1, [])
  f3 = Floor.new(2, [])
  f4 = Floor.new(3, [lg,hg])


  g1 = Floor.new(0, [lm,hm])
  g2 = Floor.new(1, [])
  g3 = Floor.new(2, [])
  g4 = Floor.new(3, [hg,lg])


  #puts f1.safe

  a = Building.new(2,[f1,f2,f3,f4])
  b = Building.new(2,[g1,g2,g3,g4])

puts [a,b].uniq{|b|b.to_generic_s}.count
puts a.to_generic_s

  #
  # start = Building.new(2,[f1,f2,f3,f4])
  # route = Route.new([start])
  # puts next_states(route).map{|r|r.to_s}
  # if (next_states(route).any?{|r|r.solved})
  #   puts "Solved!"
  # end
end


# test
# process_debug
 process_real
