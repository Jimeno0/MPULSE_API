class ApplicationController < ActionController::API
  before_action :current_user
  private
  def current_user
    if (params[:token])
      @user = User.find_by(token: params[:token])
    end
    render json: { error: "user not found"}, status: 404 unless @user
  end
end
