# frozen_string_literal: true
require 'rails_helper'

describe User, type: :model do
  subject(:user) { described_class.new }

  let(:update_attr) do
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      points: 500
    }
  end

  describe 'validations' do
    it { is_expected.not_to be_valid }

    it 'is valid when filled in' do
      user.update_attributes(update_attr)

      expect(user).to be_valid
    end
  end
end
