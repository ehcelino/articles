class ArticlesController < ApplicationController
  before_action :dissolve, only: [:index] # backpedal gem
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like, :unlike]

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
    Like.create(user_id: current_user.id, article_id: @article.id)
    respond_to do |format|
      format.html { redirect_to @article }
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('like', partial: 'like', locals: { article: @article })]
      end
    end
  end

  def unlike
    @likes = Like.where(user_id: current_user.id, article_id: @article.id)
    @likes[0].destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('like', partial: 'like', locals: { article: @article })]
      end
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to @article }
        format.turbo_stream { redirect_to @article }
      end
    else
      render :edit
    end
  end

  def show
    @comments = @article.comments.roots
    respond_to do |format|
      format.html 
      format.json { render json: @article }
      # format.turbo_stream {do
      #   render turbo_stream: [turbo_stream.replace('view_comments', partial: 'view_comments', locals: { comments: @comments }),
      #   turbo_stream.update('comment_frame', '<div></div>')]
      # end}
    end

  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Artigo criado com sucesso."
      redirect_to @article
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_dashboard_manage_articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :user_id, :category_id, :content)
  end

end
