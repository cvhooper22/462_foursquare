class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    if current_user
      redirect_to :controller => 'users', :action => 'index'
    end
  end

  def login
  	session[:current_user] = params[:username]
  	redirect_to :controller => 'users', :action => 'index'
  end

  def logout
  	reset_session
  	redirect_to root_path
  end

  def signup
  	@user = User.new
  end

  def current_user
  	return unless session[:current_user]
  	@current_user ||= User.by_username(session[:current_user])
  end

  # def require_login
  # 	unless current_user 
  # 		redirect_to root_path
  # 	end
  # end
end
