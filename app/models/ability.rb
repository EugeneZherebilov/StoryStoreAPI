class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :read, to: :see

    can [:update, :destroy], Game do |game|
      user.id == game.user_id.id
    end

    can [:update, :destroy], Group do |group|
      user.id == group.user_id.id && user.role == 'superuser'
    end
  end
end
