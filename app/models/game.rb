require 'elo/calculator'

class Game < ActiveRecord::Base
  # relations
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  # validations
  validates :user1, presence: true
  validates :user2, presence: true
  validates :score_user1, numericality: true
  validates :score_user2, numericality: true
  validate :ensure_distinct_users
  validate :ensure_winning_score

  # store
  store :meta, accessors: [:match_type]

  # hooks
  before_save :set_points

  def calculate_points
    Elo::Calculator.p(
      user1.points,
      user2.points,
      score_user1,
      score_user2,
      match_type
    )
  end

  private

  def set_points
    self.points = calculate_points
  end

  # validation methods
  def ensure_distinct_users
    errors.add(:user1, 'Users must be distinct') if user1 == user2
  end

  def ensure_winning_score
    errors.add(:score_user1, 'Must be a winning score') if score_user1 == score_user2
  end
end
