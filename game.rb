class Game
  require './player'
  require './deck'
  require './blackjack'

  attr_reader :players
  
  def initialize(deck_config: {}, num_decks: 1, num_players: 4, hand_size: 0)
    @players = get_players(num_players)
    @deck = Deck.new(deck_config: deck_config, num_decks: num_decks)
    # if no defined hand size, deal the entire deck
    @hand_size = (@deck.count / num_players).ceil if hand_size == 0
    @dealer_index = 0
  end

  def get_players(num_players)
    players = Array.new(num_players) { Player.new(current_game: self) }
    players[dealer_index].make_dealer!
  end

  def shuffle
    @deck.shuffle()
  end

  def dealer
    @players[@dealer_index] 
  end

  def end_round 
    @players.each { |player| player.turn_in_cards }
  end

  # shuffles the whole deck by default
  def deal
    end_round()
    shuffle()
    rounds_dealt = 0
    while rounds_dealt < @hand_size
      @players.each do | player |
        if card = @deck.draw()
          player.hand << card
        else
          return
        end
      end
      rounds_dealt += 1
    end
  end

  def draw(num = 1)
    return @deck.draw(num)
  end

end
