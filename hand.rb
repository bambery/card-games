class Hand 

  include Enumerable

  def initialize 
    @cards = []
  end

  # can accept single cards or an array of cards
  def << more_cards
    @cards.concat(Array(more_cards))
  end

  def == other
    @cards == other
  end

  def each(&block)
    @cards.each(&block)
  end

  def empty?
    @cards.empty?
  end

  def to_s 
    return "| " + @cards.map{|card| card.to_s }.join(" | ") + " |"
  end

  def sort_by property
    case property
      when :suit
        @cards.sort_by!{ |card| [card.suit, card.rank] }
        return self
      when :rank
        @cards.sort_by!{ |card| [card.rank, card.suit] }
        return self
    end
  end

end
