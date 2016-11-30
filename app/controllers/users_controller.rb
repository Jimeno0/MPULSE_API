class UsersController < ApplicationController

  before_action :current_user, except: [:create]

  def show
    render json: { user: @user }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      ##Falta por meter el error que nos devuelva la BBDD
      render json: { error: "cannot create user"}, status: 400
    end
  end

  def update

    if @user.update(user_params)
      render json: @user, status: 201
    else
      render json: { error: "cannot update user"}, status: 400
    end

  end


  def destroy
    #Comprobar si se destruye?? Se destruye siempre no????
  @user.destroy
  render json: @user, status: 200
  end

  private
  def user_params
   params.permit(:name, :email, :password, :password_confirmation)
  end

  def current_user
    @user = User.find_by(token: params[:token])
    unless @user
      render json: { error: "user not found"}, status: 404
      return
    end
  end
end
