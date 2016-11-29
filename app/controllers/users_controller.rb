class UsersController < ApplicationController
  # before_action :is_logged_in?, except: [:new, :create]
  # skip_before_action :is_logged_in?, only: [:new, :create]
  # before_action :is_themself?, only: [:edit, :update, :destroy]


  def show
    render json: { come: "show"}
    # @user = User.find(params[:id])
  end

  # POST /users
  def create
    render json: { come: "create", name: params[:name], password: params[:password]}
    # @user = User.new(user_params)
    #
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: 'User was successfully created.' }
    #   else
    #     format.html { render :new }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  def update
    render json: { come: "update", name: params[:name], password: params[:password]}
    # @user = User.find(params[:id])
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #   else
    #     format.html { render :edit }
    #   end
    # end
  end

  # DELETE /users/1
  def destroy
    render json: { come: "destroy"}
    # @user = User.find(params[:id])
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    # end
  end

  # private
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def user_params
  #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  #   end
  #
  #   def is_themself?
  #     @user = User.find(params[:id])
  #     unless current_user.id == @user.id
  #       redirect_to current_user
  #     end
  #   end


end
