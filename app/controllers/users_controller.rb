class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      flash[:notice] = "Logado com sucesso."
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private

  def user_params
    params.require(:user).permit(:auth_token, :username, :email, :password, :password_confirmation, :admin, :fullname)
  end

end
