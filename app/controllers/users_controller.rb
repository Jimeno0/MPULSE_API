class UsersController < ApplicationController
  skip_before_action :current_user, only: [:create]

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
end
