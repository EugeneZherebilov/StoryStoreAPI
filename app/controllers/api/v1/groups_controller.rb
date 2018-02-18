class Api::V1::GroupsController < BaseController

  before_action :authenticate_user!, except: %i[index]
  load_and_authorize_resource only: %i[update destroy]

  def index
    @groups = Group.all
    render :index
  end

  def create
    @group = Group.accessible_by(current_ability).create(create_group_params)
    if @group.valid?
      @group.save!
      render :create, status: :created
    else
      render json: { errors: @group.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render :show, status: :ok
  end

  def update
    group_updated = @group.update_attributes(update_group_params)
    if group_updated
      render :update, status: :ok
    else
      render json: { errors: @group.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @group.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def create_group_params
    params.require(:group).permit(:name, :description)
  end

  def update_group_params
    params.require(:group).permit(:name, :description)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
