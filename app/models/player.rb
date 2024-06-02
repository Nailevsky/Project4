class Player < ApplicationRecord
    has_many :moves
    has_many :games, through: :moves
  
    STRATEGIES = %w[always_cooperate always_betray tit_for_tat random].freeze
  
    def make_move(opponent_moves)
      case strategy
      when 'always_cooperate'
        'cooperate'
      when 'always_betray'
        'betray'
      when 'tit_for_tat'
        tit_for_tat_strategy(opponent_moves)
      when 'random'
        random_strategy
      else
        raise "Unknown strategy: #{strategy}"
      end
    end
  
    private
  
    def tit_for_tat_strategy(opponent_moves)
      return 'cooperate' if opponent_moves.empty?
      opponent_moves.last
    end
  
    def random_strategy
      %w[cooperate betray].sample
    end
  end  