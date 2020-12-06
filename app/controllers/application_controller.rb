class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to("/")
    end
  end

  def un_authenticate_user
    unless @current_user == nil
      flash[:notice] = "すでにログインしています"
      redirect_to("/")
    end
  end
  
end
