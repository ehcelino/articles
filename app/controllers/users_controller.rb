class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      @session = Session.create(user: @user, login_at: Time.now)
      flash[:success] = "Logado com sucesso."
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    render layout: "admin"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Informações atualizadas com sucesso.'
      return redirect_to user_path(@user)
    else
      # flash[:danger] = "Algo deu errado."
      render :edit, status: :unprocessable_entity, content_type: "text/html"
      # redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:auth_token, :username, :email, :password, :password_confirmation, :admin, :fullname)
  end

end
