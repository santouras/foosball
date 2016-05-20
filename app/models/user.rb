# frozen_string_literal: true
class User < ApplicationRecord
  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :points, numericality: true

  def games
    Game.where('user1_id = :id OR user2_id = :id', id: id)
  end

  def display_name
    nickname || full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
