class SessionsController < ApplicationController
  skip_before_action :current_user, except: [:destroy]

  def create
    user = User.find_by(email: params[:email])
    unless user && user.authenticate(params[:password])
      render json: { error: "invalid user or password" }, status: 400
      return
    end
    user.regenerate_token
    render json: user, status: 200
  end

  def destroy
    @user.update(token: nil)
    render json: @user, status: 200
  end
end
