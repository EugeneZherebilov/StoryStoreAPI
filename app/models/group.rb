class Group < ApplicationRecord


  belongs_to :user
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
end
