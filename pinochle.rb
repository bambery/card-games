class Pinochle < Game
  require('./game.rb')

  DECK_CONFIG  = 
    { :cards => { "9" => { value: 0, rank: 1 },
                  "J" => { value: 0, rank: 2 },
                  "Q" => { value: 0, rank: 3 },
                  "K" => { value: 1, rank: 4 },
                  "10" => { value: 1, rank: 5 },
                  "A" => { value: 1, rank: 6 }
                },
      :num_sets => 2
    }

  def initialize
    super deck_config: DECK_CONFIG 
  end

end
