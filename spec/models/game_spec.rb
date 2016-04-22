require 'rails_helper'

describe Game, type: :model do
  subject(:game) { described_class.new }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe "validations" do
    it { is_expected.not_to be_valid }

    it "is valid when filled in" do
      game.update_attributes({
        user1: user1,
        user2: user2,
        score_user1: 10,
        score_user2: 9
      })

      expect(game).to be_valid
    end
  end
end
