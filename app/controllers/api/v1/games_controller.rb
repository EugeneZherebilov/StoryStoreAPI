class Api::V1::GamesController < BaseController

  before_action :create_conversation_with_users, only: [:create]

  def index
    @conversations = current_user.conversations
    render :index
  end

  def create
    if @users_ids
      @conversation = current_user.conversations.create
      if @conversation.persisted?
        @conversation.add_users(@users_ids)
        render :create
      else
        render json: { errors: @conversation.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Please add users_ids' }, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end


  private

  def conversation_params
    params.require(:conversation).permit(:name)
  end

  def create_conversation_with_users
    @users_ids = params[:conversation][:users_ids] if params[:conversation][:users_ids] && params[:conversation][:users_ids].length > 0
  end

end