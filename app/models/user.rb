class User < ActiveRecord::Base
  #searchkick text_middle: [:name]

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  NAME_LENGTH_MAXIMUM = 50
  NAME_LENGTH_MINIMUM = 1
  NAME_REGEX_VALIDATE = /\A([^~!@#'`"\\\/.()?,|*&%_+$;:\[\]{}><=\^\s\-]([^~!@#`"\\\/.()?,|*&%_+$;:\[\]{}><=\^]*[^~!@#'`"\\\/.()?,|*&%_+$;:\[\]{}><=\^\s\-])?){1,200}\z/

  validates :name,
            format: { with: NAME_REGEX_VALIDATE},
            length: { maximum: NAME_LENGTH_MAXIMUM, minimum: NAME_LENGTH_MINIMUM },
            allow_nil: false

  FACEBOOK_AVATAR = ['?width=400&height=400', '?type=large', ''].freeze
  GOOGLE_AVATAR = ['', '?sz=145', '?sz=45'].freeze
  ST_AVATAR = ['', '_medium', '_small'].freeze

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
