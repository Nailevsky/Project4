module Players
    class TitForTat
      def make_move(round, user_moves)
        return 'cooperate' if round == 1
        user_moves[round - 2] == 'cooperate' ? 'cooperate' : 'betray'
      end
    end
  end