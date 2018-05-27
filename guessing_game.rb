# NO techniques just write down algorithms
require 'securerandom'

class GuessingGame
  def self.play
    @number = random_number

    trial_number = 10
    puts "You can try #{trial_number} times."

    trial_number.downto(0) do |credit|
      print 'Enter 4 digit number:'
      @input = gets.strip
      unless @input.to_s.size == 4
        puts 'Not 4 digit number.'
        next
      end
      if @input.to_s == @number.to_s
        win!(credit)
      end
      calc
    end

    lose!
  end

  def self.random_number
    while
      num = SecureRandom.random_number(10000)
      if num >= 1000 && num.digits.size == num.digits.uniq.size
        break num
      end
    end
  end

  def self.calc
    exact = 0
    patrial = 0
    0.upto(3) do |i|
      n1 = @number.to_s[i]
      n2 = @input.to_s[i]
      if n1 == n2
        exact += 1
      elsif @number.to_s.include?(n2)
        patrial += 1
      end
    end
    puts "Exact match: #{exact}, partial match: #{patrial}."
  end

  def self.win!(credit)
    puts "You win! #{credit} credits left."
    exit
  end

  def self.lose!
    puts "You lose! The number was: #{@number}"
    exit
  end
end

GuessingGame.play
