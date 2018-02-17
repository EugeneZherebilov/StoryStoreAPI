class User < ActiveRecord::Base
  searchkick text_middle: [:name]

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  FACEBOOK_AVATAR = ['?width=400&height=400', '?type=large', '']
  GOOGLE_AVATAR = ['', '?sz=145', '?sz=45']
  ST_AVATAR = ['', '_medium', '_small']

  has_many :identities, dependent: :destroy
  has_many :game_users, dependent: :destroy

  def return_avatar(enum)
    type = ['large', 'medium', 'small']
    if self.image && self.image.include?('facebook')
      self.image + FACEBOOK_AVATAR[type.index(enum)]
    elsif self.image && self.image.include?('googleusercontent')
      self.image + GOOGLE_AVATAR[type.index(enum)]
    elsif self.image
      self.image + ST_AVATAR[type.index(enum)]
    end
  end
end
