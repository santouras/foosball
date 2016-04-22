require 'rails_helper'

describe User, type: :model do
  subject(:user) { described_class.new }

  describe "validations" do
    it { is_expected.not_to be_valid }

    it "is valid when filled in" do
      user.update_attributes({
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        points: 500
      })

      expect(user).to be_valid
    end
  end
end
