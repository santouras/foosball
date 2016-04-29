require 'rails_helper'

describe Game, type: :model do
  subject(:object) { described_class.new }

  let(:game) { create(:game) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe "validations" do
    it { is_expected.not_to be_valid }

    it "is valid when filled in" do
      object.update_attributes({
        user1: user1,
        user2: user2,
        score_user1: 10,
        score_user2: 9,
        match_type: :friendly
      })

      expect(object).to be_valid
    end

    it "doesn't allow the same user twice" do
      game.update_attributes({
        user1: user1,
        user2: user1
      })

      expect(game).not_to be_valid
    end

    it "doesn't allow a draw" do
      game.update_attributes({
        score_user1: 10,
        score_user2: 10
      })

      expect(game).not_to be_valid
    end
  end

  describe "hooks" do
    let!(:game) { build(:game) }

    it "fires set_points before saving" do
      expect(game).to receive(:set_points)

      game.save
    end
  end

  describe "#calculate_points" do
    before do
      allow(Elo::Calculator).to receive(:p).
        and_return(0)
    end

    it "calls Elo::Calculator" do
      expect(Elo::Calculator).to receive(:p).
        with(
          user1.points,
          user2.points,
          game.score_user1,
          game.score_user2,
          game.match_type
        )

      game.calculate_points
    end
  end
end
