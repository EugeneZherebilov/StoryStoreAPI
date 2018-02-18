class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :read, to: :see

    can [:update, :create, :destroy], Game do
      user.role == 'master'
    end

    can [:update, :create, :destroy], Group do
      user.role == 'master'
    end
  end
end
