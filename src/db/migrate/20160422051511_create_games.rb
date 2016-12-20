class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer  :score_user1
      t.integer  :score_user2
      t.float    :points
      t.datetime :game_time
      t.text     :meta

      t.timestamps null: false
    end

    add_reference :games, :user1, references: :users, after: :id
    add_reference :games, :user2, references: :users, after: :user1_id
  end
end
