class Api::V1::GamesController < BaseController

  before_action :authenticate_user!, except: %i[index]
  before_action :find_game, only: %i[update destroy add_player delete_player]

  def index
    @games = Game.all
    render :index
  end

  def create
    @game = Game.create(create_game_params)
    if @game.valid?
      @game.save!
      render :create, status: :created
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def show
    render :show, status: :ok
  end

  def update
    game_updated = @game.update_attributes(update_game_params)
    if game_updated
      render :update, status: :ok
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @game.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end
  
  def add_player
    @player = @game.add_player(@user)
    if @player
      render :add_player, status: :ok
    else
      render json: { errors: @player.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def delete_player
    if find_game_user.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end


  private

  def create_game_params
    params.require(:game).permit(:name, :description, :type_id, :image, :count_players, :access, :start_time)
  end
  
  def update_game_params
    params.require(:game).permit(:name, :description, :type_id, :image, :count_players, :access, :start_time)
  end

  def find_game
    @game = if params[:game_id]
      Game.find_by(id: params[:game_id])
    else
      Game.find_by(id: params[:id])
            end
    head(:not_found) unless @game
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
    head(:not_found) unless @user
  end
  
  def find_game_user
    GameUser.find_by(game_id: @game.id, user_id: @user.id)
  end

end