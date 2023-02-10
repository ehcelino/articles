class ArticlesController < ApplicationController
  before_action :remember_page, only: [:index, :show]

  def index
    page = params[:page] || 1
    @per_page = Setting.per_page
    offset = (page.to_i - 1) * @per_page
    @articles = Article.offset(offset).limit(@per_page).order(created_at: :desc)
    # @articles = Article.all
    # @comments = Comment.all
    @actual = params[:page] || 1
  end

  def like
    @article = Article.find(params[:id])
    Like.create(user_id: current_user.id, article_id: @article.id)
    redirect_to @article
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.roots
    respond_to do |format|
      format.html
      format.json { render json: @article }
    end

  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Artigo criado com sucesso."
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :user_id, :category_id, :content)
  end

end
