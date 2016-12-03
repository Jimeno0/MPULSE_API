class UsersController < ApplicationController
  before_action :current_user, except: [:create]

  def create
    @user = User.new(user_params)
    return render json: @user, status: 201 if @user.save
    render json: { error: "cannot create user"}, status: 400
  end

  def update
    return render json: @user, status: 201 if @user.update(user_params)
    render json: { error: "cannot update user"}, status: 400
  end

  def destroy
    @user.destroy
    render json: @user, status: 200
  end

  private
  def user_params
   params.permit(:name, :password, :email, :password_confirmation)
  end

  def current_user
    @user = User.find_by(token: params[:token])
    return  render json: { error: "user not found"}, status: 404 unless @user
  end
end
