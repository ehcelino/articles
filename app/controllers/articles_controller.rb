class ArticlesController < ApplicationController

  def index
    page = params[:page] || 1
    @per_page = Setting.per_page
    offset = (page.to_i - 1) * @per_page
    @articles = Article.offset(offset).limit(@per_page).order(created_at: :desc)
    # @articles = Article.all
    # @comments = Comment.all
    @actual = params[:page] || 1
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.roots
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
