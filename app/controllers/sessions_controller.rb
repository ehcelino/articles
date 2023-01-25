class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if user.admin?
        flash[:success] = "Sessão de administrador iniciada com sucesso."  
        redirect_to admin_dashboard_index_path
      else
        flash[:success] = "Sessão iniciada com sucesso."
        redirect_to root_url
      end
    else
      flash[:danger] = "Usuário ou senha inválidos."
      redirect_to login_path
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    flash[:success] = "Sessão encerrada com sucesso."
    redirect_to root_url
  end

end
