# frozen_string_literal: true
UserType = GraphQL::ObjectType.define do
  name 'User'
  description '...'

  field :id, !types.ID
  field :first_name, !types.String
  field :last_name, !types.String
  field :display_name, !types.String
  field :points, !types.Float
  field :games, -> { types[GameType] }
end

GameType = GraphQL::ObjectType.define do
  name 'Game'
  description '...'

  field :id, !types.ID
  field :score_user1, !types.Int
  field :score_user2, !types.Int
  field :points, !types.Float
  field :game_time, !types.String
  field :user1, !UserType
  field :user2, !UserType
  field :match_type, !types.String
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :user do
    type UserType
    description 'A user'
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) { User.find(args[:id]) }
  end

  field :game do
    type GameType
    description 'A game'
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) { Game.find(args[:id]) }
  end
end

Schema = GraphQL::Schema.new(
  query: QueryType
)
