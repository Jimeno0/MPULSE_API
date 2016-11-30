class SessionsController < ApplicationController

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
    user.update(token: nil)
    render json: { message: "logout successfully"}, status: 200
  end
end
