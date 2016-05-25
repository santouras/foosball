# frozen_string_literal: true
require 'rails_helper'

describe User, type: :model do
  subject { described_class.new }
  let(:user) { create(:user, nickname: nickname) }
  let(:nickname) { nil }

  let(:update_attr) do
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      email: FFaker::Internet.email,
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

  describe '#display_name' do
    subject { user.display_name }

    context 'with a nickname' do
      let(:nickname) { FFaker::Internet.user_name }

      it { is_expected.to eq(nickname) }
    end

    context 'without a nickname' do
      it { is_expected.to eq("#{user.first_name} #{user.last_name}") }
    end
  end

  describe '#full_name' do
    subject { user.full_name }

    it { is_expected.to eq("#{user.first_name} #{user.last_name}") }
  end
end
