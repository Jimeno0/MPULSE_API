class SessionsController < ApplicationController
  skip_before_action :current_user, except: [:destroy]

  def create
    user = User.find_by(email: params[:email])
    user_by_token = User.find_by(token: params[:token])
    if user && user.authenticate(params[:password])
      user.regenerate_token
      render json: user, status: 200
    elsif user_by_token
      render json: user_by_token, status: 200
    else
      render json: { error: "invalid user or password" }, status: 400
    end
  end

  def destroy
    @user.update(token: nil)
    render json: @user, status: 200
  end
end
