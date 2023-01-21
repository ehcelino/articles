class ApplicationController < ActionController::Base
  require 'ostruct'
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
      OpenStruct.new(name: 'Visitante')
    end
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      flash[:danger] = "Faça login para continuar."
      redirect_to login_url
    end
  end

end
