module Elo
  class Calculator
    class << self
      # kg(w - we)
      # k = weight index
      # g = goal difference
      # w = result
      # we = expected result
      def p pts1, pts2, score1, score2, weight
        weight * g(score1, score2) * (w(score1, score2) - we(pts1, pts2))
      end

      # 1/(10^-(dr/400) + 1)
      # dr = difference in ratings
      def we pts1, pts2
        (1 / ( 10 ** ( - (pts1 - pts2) / 400.0) + 1)).round(3)
      end

      def w score1, score2
        case score1 <=> score2
        when 1
          1
        when 0
          0.5
        when -1
          0
        end
      end

      # goal difference
      # 0/+1 = 1
      # +2 = 3/2
      # +3 and higher = (11 + diff) / 8
      def g score1, score2
        difference = score_difference(score1, score2)
        case difference
        when 0, 1
          1
        when 2
          3/2.0
        else
          (11 + difference) / 8.0
        end
      end

      def score_difference score1, score2
        diff = score1 - score2
        diff *= -1 if diff < 0
        diff
      end
    end
  end
end
