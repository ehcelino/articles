class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :check_admin

  def index
    @articles = Article.all
    @comments = Comment.all
    @users = User.all
    @sessions = Session.order(login_at: :desc).limit(3)
  end
  
  def manage_articles
    @articles = Article.all.order(created_at: :desc)
  end
  
  private

  def check_admin
    if !current_user.admin?
      flash[:danger] = "Você não tem permissão para acessar esta página."
      redirect_to root_url
    end
  end

end
