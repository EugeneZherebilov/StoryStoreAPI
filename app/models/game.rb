class Game < ApplicationRecord
  has_many :game_users, dependent: :destroy
  has_many :users, through: :game_users

  def add_users(users_ids)
    users = User.where("users.id in (?)", users_ids)
    users.each do |user|
      GameUser.create(conversation_id: self.id, user_id: user.id )
    end
  end
end