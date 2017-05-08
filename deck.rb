class Deck
  require('./card.rb')

  DEFAULT_DECK_CONFIG =
    {
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
                   "A" => { value: 10, rank: 14 }
                  },
      :num_sets => 1, # number of sets of cards in a deck.
      :suits    => [:hearts, :spades, :diamonds, :clubs]
    }

  def initialize(deck_config: {}, num_decks: 1)
    # no good way to have chained methods with named keyword params
    deck_config = DEFAULT_DECK_CONFIG.merge(deck_config)

    @cards = Array.new
    (num_decks * deck_config[:num_sets]).times do  
      deck_config[:cards].each do | face, card_attrs |
        deck_config[:suits].each do |suit|
          @cards << Card.new(face: face, rank: card_attrs[:rank], value: card_attrs[:value], suit: suit)
        end
      end
      @draw_index = 0
    end
  end

  # shuffles all cards back into deck
  def shuffle
    @cards.shuffle!
    @draw_index = 0
  end

  def count
    return @cards.count
  end

  # returns a new card until the deck is empty
  def draw(num = 1)
    new_cards = []
    num.times do
      if @draw_index == @cards.count
        puts "The deck is empty!"
        return nil # deck empty!
      else
        @draw_index += 1
          new_cards << @cards[@draw_index - 1]
      end
    end
    return new_cards
  end

end
