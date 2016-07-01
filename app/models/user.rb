# frozen_string_literal: true
class User < ActiveRecord::Base
  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :points, numericality: true

  def games
    Game.where('user1_id = :id OR user2_id = :id', id: id)
  end
end
