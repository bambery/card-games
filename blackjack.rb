class Blackjack < Game
  require('./game.rb')
  # split out blackjack player into module
  require('./player.rb')

  attr_reader :players
  attr_accessor :dealer

  DECK_CONFIG = {
      :cards    => {  "2" => { value: 2, rank: 2 }, 
                   "3" => { value: 3, rank: 3 }, 
                   "4" => { value: 4, rank: 4 }, 
                   "5" => { value: 5, rank: 5 },
                   "6" => { value: 6, rank: 6 }, 
                   "7" => { value: 7, rank: 7 },
                   "8" => { value: 8, rank: 8 }, 
                   "9" => { value: 9, rank: 9 },
                   "10" => { value: 10, rank: 10 }, 
                   "J" => { value: 10, rank: 11 }, 
                   "Q" => { value: 10, rank: 12 },
                   "K" => { value: 10, rank: 13 },
                   "A" => { value: 11, rank: 14 }

      }
  }

  DEALER_STAY = 17

  def initialize(num_decks: 2, num_players: 1)
    @players, @dealer = get_players(num_players)
    @deck = Deck.new(deck_config: DECK_CONFIG, num_decks: num_decks) 
    @hand_size = 2 
  end

  # blackjack has a house dealer who is not counted as a player
  # FIXME dealer should not be a player, but should still count for deals and etc
  def get_players(num_players)
    players = Array.new( num_players + 1 ) { BlackjackPlayer.new(current_game: self)}
    players.first.make_dealer!
    return [players, players.first]
  end

  def dealer_plays(dealer_stay: DEALER_STAY)
    @dealer.dealer_plays(dealer_stay)
    # Round should end immediately after dealer plays and winner is determined
  end

  def hit
    return @deck.draw
  end

end
