module Anki
  class Deck
    attr_accessor :name, :desc
    attr_reader :id, :cards

    def initialize name
      @name = name
      @id = Anki::Helper.get_id
      initialize_cards
    end

    def initialize_cards
      @cards = {}

      #change @cards#to_s to prevent recursive output via parent / child relationship
      class << @cards
        def to_s
          "#< #{self.keys.count} cards>"
        end
        alias_method :inspect, :to_s
      end
    end

    # adds a card to the deck
    def add_card card
      card.deck = self
      @cards[card.id] = card
    end

    # adds a card, and then inserts the inverted version of the card immediately after
    def add_card_with_inversion card
      add_card card
      add_card card.invert
    end

    # add inverted versions of the cards at the end of the deck
    def add_inversions
      @cards.values.each {|c| add_card c.invert }
    end

    # invert the faces of every card in place
    def invert!
      @cards.values.each {|c| c.invert! }
    end

    def cards
      @cards.values
    end

    def [] id
      @cards[id]
    end

    def initialize_copy(orig)
      super
      initialize_cards
      orig.cards.each { |c| add_card c.dup }
    end
  end



  class Type
    def self.new_type
      0
    end
  end

  class Queue
    def self.new_queue
      0
    end
  end
end
