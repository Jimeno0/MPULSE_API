class UsersController < ApplicationController

  skip_before_action :is_logged_in?, only: [:new, :create]
  before_action :is_themself?, only: [:edit, :update, :destroy]


  def show
    @user = User.find_by(token: params[:token])
    render json: { user: @user }

  end

  # POST /users
  def create
    render json: { come: "create", name: params[:name], password: params[:password]}
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: 201
    else
      render json: { error: "cannot create user"}, status: 400
    end

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

  private
  #   # Never trust parameters from the scary internet, only allow the white list through.
   def user_params
     params.require(:user).permit(:name, :password, :password_confirmation)
   end
  #
    def is_themself?
      @user = User.find_by(token: params[:token])

      unless current_user.token == @user.token
        redirect_to '/'
      end
    end


end
