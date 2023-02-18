class ApplicationController < ActionController::Base
  require 'ostruct'
  before_action :capture_path, if: :current_user # backpedal gem
  # before_action :store_history
  # after_action :check_for_404
  
  private

  # def current_user
  #   @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  # end
  # helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    if @current_user
        @current_user
    else
      OpenStruct.new(username: 'Visitante')
    end
  end
  helper_method :current_user


  # def store_history
  #   session[:history] ||= []
  #   session[:history].delete_at(0) if session[:history].size >= 5
  #   session[:history] << request.url
  # end

  # def authorize
  #   if current_user.nil?
  #     flash[:danger] = "Faça login para continuar."
  #     redirect_to login_url
  #   end
  # end

  # def check_for_404
  #   if response.status == 404
  #     render :template => "errors/not_found"
  #   end
  # end
  
end
