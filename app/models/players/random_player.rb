module Players
    class RandomPlayer
      def make_move(round, user_moves)
        ['cooperate', 'betray'].sample
      end
    end
  end  