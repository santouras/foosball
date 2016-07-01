# frozen_string_literal: true
module Elo
  class Calculator
    class << self
      MATCH_TYPE = {
        world_cup: 60,
        continental_championship: 50,
        intercontinental_tournament: 50,
        world_cup_qualifier: 40,
        continental_qualifier: 40,
        major_tournament: 40,
        other_tournament: 30,
        friendly: 20
      }.freeze

      RESULT_INDEX = {
        '1' => 1,
        '0' => 0.5,
        '-1' => 0
      }.freeze

      # kg(w - we)
      # k = weight index
      # g = goal difference
      # w = result
      # we = expected result
      def p(pts1, pts2, score1, score2, match_type)
        (k(match_type) * g(score1, score2) * (w(score1, score2) - we(pts1, pts2))).round(2)
      end

      # 1/(10^-(dr/400) + 1)
      # dr = difference in ratings
      def we(pts1, pts2)
        (1 / (10**(- (pts1 - pts2) / 400.0) + 1)).round(3)
      end

      def w(score1, score2)
        RESULT_INDEX[(score1 <=> score2).to_s]
      end

      # goal difference
      # 0/+1 = 1
      # +2 = 3/2
      # +3 and higher = (11 + diff) / 8
      def g(score1, score2)
        difference = score_difference(score1, score2)
        case difference
        when 0, 1
          1
        when 2
          3 / 2.0
        else
          (11 + difference) / 8.0
        end
      end

      def score_difference(score1, score2)
        diff = score1 - score2
        diff *= -1 if diff < 0
        diff
      end

      def k(match_type)
        match_type = :friendly unless MATCH_TYPE.key? match_type.to_sym
        MATCH_TYPE[match_type.to_sym]
      end
    end
  end
end
