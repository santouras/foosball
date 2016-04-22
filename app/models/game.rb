class Game < ActiveRecord::Base
  # relations
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  # validations
  validates :user1, presence: true
  validates :user2, presence: true
  validates :score_user1, numericality: true
  validates :score_user2, numericality: true
end
