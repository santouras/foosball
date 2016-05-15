class GameSerializer < ActiveModel::Serializer
  attributes :id, :user1_id, :user2_id, :score_user1, :score_user2, :points, :game_time, :meta

  has_many :users
end
