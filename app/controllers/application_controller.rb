class ApplicationController < ActionController::API
  before_action :is_logged_in?, except: [:new, :create]
  def current_user
    @current_user ||= User.find_by(token: params[:token])
  end

  def logged_in?
    !current_user.nil?
  end

  def is_logged_in?
    unless logged_in?
      redirect_to '/'
    end
  end
end
