class ApplicationController < ActionController::API
  before_action :current_user
  private
  def current_user
    @user = User.find_by(token: params[:token])
    return  render json: { error: "user not found"}, status: 404 unless @user
  end
end
