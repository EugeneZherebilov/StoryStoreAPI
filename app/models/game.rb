class Game < ApplicationRecord
  has_many :game_users, as: :players, dependent: :destroy
  has_many :users, through: :game_users

  NAME_LENGTH_MAXIMUM = 50
  DESCRIPTION_LENGTH_MAXIMUM = 300
  DATA_LENGTH_MINIMUM = 1

  validates :name,
            allow_nil: false, allow_blank: false,
            length: { maximum: NAME_LENGTH_MAXIMUM, minimum: DATA_LENGTH_MINIMUM }
  validates :description,
            allow_nil: false, allow_blank: false,
            length: { maximum: DESCRIPTION_LENGTH_MAXIMUM, minimum: DATA_LENGTH_MINIMUM }
  validates :type_id,
            allow_nil: false, allow_blank: false,
            length: { maximum: 50, minimum: DATA_LENGTH_MINIMUM }
  validates :count_players,
            allow_nil: false, allow_blank: false,
            length: { maximum: 100, minimum: 1 }

  enum access: %i[common secret], _prefix: :access


  def add_player(user)
    GameUser.create(game_id: id, user_id: user.id)
  end
end