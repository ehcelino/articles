class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @session = Session.create(user: user, login_at: Time.now)
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
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end
  
  def destroy
    @session = Session.find_by(user_id: current_user.id, logout_at: nil)
    @session.update(logout_at: Time.now)
    session.delete(:user_id)
    cookies.delete(:auth_token)
    flash[:success] = "Sessão encerrada com sucesso."
    redirect_to root_url
  end

end
