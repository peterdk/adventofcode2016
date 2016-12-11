class Robot

  attr_accessor :low,:high, :number, :values,:input_receive

  def initialize(number)
    @number = number
    @values = []
    @low = nil
    @high = nil
  end



  def can_proceed
    @values.length >= 2
  end

  def proceed
    sorted = @values.sort
    puts "#{number}: #{@low.number if low } receives #{sorted[0]}, #{@high.number if number} receives #{sorted[1]}"
    @low.receive(sorted[0]) if @low
    @high.receive(sorted[1]) if @high
    @values = []
    sorted
  end

  def receive(value)
    puts "#{number} received #{value}"
    @values << value
  end

  def to_s
    "bot #{number}: #{@values.inspect} => low: #{@low.number if @low}, high: #{@high.number if @high}"
  end

  def inspect
    to_s
  end

end

class Processor

  def initialize(commands)
    @bots = []
    @outputs = []
    commands.each do |c|
      if (c.match(/value (\d+) goes to bot (\d+)/))
        puts c
        bot($2.to_i).receive($1.to_i)

      elsif (c.match(/bot (\d+) gives low to (output|bot) (\d+) and high to (output|bot) (\d+)/))

        low_receiver = ($2 == "bot") ? bot($3.to_i): output($3.to_i)
        raise c if bot($1.to_i).low != nil
        bot($1.to_i).low = low_receiver

        high_receiver = ($4 == "bot") ? bot($5.to_i) : output($5.to_i)
        raise c if bot($1.to_i).high != nil
        bot($1.to_i).high = high_receiver

        puts "#{c} => #{bot($1.to_i).number} => low: #{low_receiver.number if low_receiver}, high:#{high_receiver.number if high_receiver}"
      else
        raise c

      end
    end
    puts @outputs.inspect
  end

  def process
    found = false
    round = 0
    while (!found)
      puts round += 1
      @bots.each do |bot|
        if (bot.can_proceed)
          bot.proceed
        end
      end

      if (@outputs[0..2].all?{|r|r.values.length > 0})
        puts "Found: #{@outputs[0..2].map{|o|o.values.first}.inject(:*)}"
        puts @outputs[0..2].inspect
        found = true
        break
      end

    end
  end

  def bot(number)
    if (!@bots[number])
      @bots[number ] = Robot.new(number)
    end
    @bots[number]
  end

  def output(number)
    if (!@outputs[number])
      @outputs[number] = Robot.new(number)
  end
  @outputs[number]
end
end

test = "value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2"
#Processor.new(test.split("\n"))

Processor.new(File.new("day10_input.txt").readlines).process
