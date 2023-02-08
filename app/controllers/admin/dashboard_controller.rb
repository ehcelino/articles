class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :check_admin

  def index
    @articles = Article.all
    @comments = Comment.all
    @users = User.all
  end
  
  private

  def check_admin
    if !current_user.admin?
      flash[:danger] = "Você não tem permissão para acessar esta página."
      redirect_to root_url
    end
  end

end
