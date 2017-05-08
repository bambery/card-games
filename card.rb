class Card

  UNICODE_SYMBOLS = {:hearts   => "\u{2665}", 
                     :spades   => "\u{2660}",
                     :diamonds  => "\u{2666}",
                     :clubs    => "\u{2663}"}

  attr_reader :face, :suit, :value, :rank

  def initialize(face:, suit:, value:, rank:)
    @face = face
    @suit = suit
    @value = value  # used for tallying points
    @rank = rank    # where this card falls in the hierarchy
  end

  def to_s
    return face + UNICODE_SYMBOLS[suit]  
  end

  def is_a(face)
    return @face == face 
  end
end
