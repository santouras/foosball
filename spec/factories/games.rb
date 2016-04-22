FactoryGirl.define do
  factory :game do
    user1 factory: :user
    user2 factory: :user
    score_user1 10
    score_user2 9
    points 10
    game_time { Time.current.utc }
  end
end
