class UsersController < ApplicationController

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password]
    )
    if user.save
      # token = JWT.encode({user_id: user.id}, 'secret')
      render json: {user: user}#, token: token}
    # else
    #   render json: {errors: user.errors.full_messages}
    end
  end

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def watchlist
    user = User.find(params[:id])
    watchlist = user.stocks
    render json: watchlist    
  end

end
