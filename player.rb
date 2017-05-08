class Player
  require './hand'
  attr_accessor :score, :is_dealer
  attr_reader :hand

  def initialize(current_game:, is_dealer: false)
    @current_game = current_game
    @hand = Hand.new
    @score = 0
    @is_dealer = is_dealer
  end

  def turn_in_cards
    @hand = Hand.new
  end

  def make_dealer!( should_be_dealer: true)
    @is_dealer = should_be_dealer
  end

end

class BlackjackPlayer < Player
  def initialize(current_game:, is_dealer: false)
    super
    @hand_totals = { 0 => { hi: 0, lo: 0 } } 
    @is_staying = false
  end

  def end_round
    turn_in_cards
    @hand_totals = { 0 => { hi: 0, lo: 0 } } 
    @is_staying = false
  end

  private def calculate_hand_totals
    @hand_totals = Hash.new 
    ace_count = 0 
    running_total = 0
    @hand.each do | card |
      running_total += card.value
      (ace_count += 1) if card.is_a("A")
    end
    @hand_totals[running_total] = { hi: ace_count, lo: 0 }

    unless ace_count == 0
      ace_count.times do | index |
        @hand_totals[(running_total - (index + 1) * 10)] = { hi: ace_count - (index + 1), lo: index + 1 }
      end
    end
  end

  def has_blackjack?
     has_winning_hand? && (@hand.count == 2)
  end

  def has_winning_hand?
    @hand_totals.keys.any?{ |total| total == 21 }
  end

  def dealer_plays(dealer_stay)
    puts "Error: this player is not the dealer" unless @is_dealer 
    while dealer_should_draw?(dealer_stay) do
      hit 
    end
  end

  def dealer_should_draw? (dealer_stay)
    calculate_hand_totals
    if has_winning_hand?
      puts "House wins with 21: #{@hand.to_s}"
      return false
    elsif !in_good_standing? 
      puts "House busts with #{@hand_totals.keys.first}: #{@hand.to_s}"
      return false
    elsif @hand_totals.keys.max >= dealer_stay
      @is_staying = true
      puts "Dealer stays with #{@hand_totals.keys.max}: #{@hand.to_s}"
      return false
    end
    return true
  end


  def hit
    # get card and add to hand
    # recalculate totals
    if @is_staying == true
      puts "Error: You decided to stay and can't draw any more cards."
    elsif in_good_standing?
      new_card = @current_game.hit
      @hand << new_card
      puts "You drew #{new_card[0].to_s}"
      calculate_hand_totals
    else
      puts "You Busted and can't draw any cards!"
    end
    total
  end

  def stay
    @is_staying = true
  end

  # players cannot be made dealers in Blackjack
  def make_dealer!
    puts "Error: Dealer is always House."
    return nil
  end

  def in_good_standing?
    @hand_totals.keys.any?{ |total| total < 21 }
  end

  # want an output like
  # You have 2 possible total(s) with 1 Ace(s):
  # 13 - [A: 1 hi, 0 lo]
  # 3 - [A: 0 hi, 1 lo] 
  def total
    calculate_hand_totals
    if @hand.empty?
      puts "Your hand is empty."
      return
    end

    puts "Your hand is #{@hand.to_s}" 

    if !in_good_standing?
      puts "*** YOU LOSE! ***"
    end

    puts "You have #{@hand_totals.count} possible total(s) with #{@hand_totals.count - 1} Aces:"
    @hand_totals.each do | total, ace_distrobution |
      if total > 21
        puts "BUSTED!- #{total} - [A: #{ace_distrobution[:hi]} hi, #{ace_distrobution[:lo]} lo]"
      elsif total == 21 && @hand.count == 2
        puts "BLACKJACK - #{total} - [A: #{ace_distrobution[:hi]} hi, #{ace_distrobution[:lo]} lo]"
      elsif total == 21
        puts "WINNING HAND - #{total} - [A: #{ace_distrobution[:hi]} hi, #{ace_distrobution[:lo]} lo]"
      else
        puts "#{total} - [A: #{ace_distrobution[:hi]} hi, #{ace_distrobution[:lo]} lo]"
      end
    end
  end

end
