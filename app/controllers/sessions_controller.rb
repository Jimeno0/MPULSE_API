class SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  def create

    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      user.regenerate_token
      render json: user, status: 200
    else
      render json: { error: "invalid user or password" }, status: 400
    end
  end

  def destroy
    @user.update(token: nil)
    render json: @user, status: 200
  end

  private
  def current_user
    @user = User.find_by(token: params[:token])
    unless @user
      render json: { error: "user not found"}, status: 404
      return
    end
  end
end
