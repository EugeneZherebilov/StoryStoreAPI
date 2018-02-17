class Api::V1:: MessagesController < BaseController

  def index
    @messages = @conversation.messages
    render :index
  end

  def create
    @message = current_user.messages.create(message_params)
    if @message.persisted?
      render :create
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end

  def find_conversation
    @conversation = Game.find(params[:conversation_id])
  end

end