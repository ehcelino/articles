class CommentsController < ApplicationController
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # before_action :set_article, only: [:new, :create]
  before_action :check_depth_limit, only: [:new]
  before_action :check_user, only: [:new, :create]
  def new
    @comment = Comment.new
    if params[:article_id]
      @article = Article.find(params[:article_id])
      session[:article_id] = @article.id
    end
    if params[:parent_id]
      @parent_comment = Comment.find(params[:parent_id])
    end
  end


  def com
    @comment = Comment.new
    if params[:article_id]
      @article = Article.find(params[:article_id])
      session[:article_id] = @article.id
    end
    if params[:comment_id]
      @parent_comment = Comment.find(params[:comment_id])
    end
  end

  def create
    Rails.logger.error("Entrou no create")
    @comment = Comment.new(comment_params)
    @article_id = session[:article_id]
    set_depth
    # @comment.article = @article
    @comment.user = current_user
    if @comment.save
      redirect_to article_path(params[:comment][:article_id]), notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def update
    set_depth
    if @comment.update(comment_params)
      redirect_to @comment.article, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.article, notice: 'Comment was successfully destroyed.'
  end

  private
    # def set_comment
    #   @comment = Comment.find(params[:id])
    # end

    # def set_article
    #   @article = Article.find(params[:article_id])
    # end

    def set_depth
      if @comment.parent.present?
        @comment.depth = @comment.parent.depth + 1
      else
        @comment.depth = 0
      end
    end

    # def store_history
    #   session[:history] ||= []
    #   session[:history].delete_at(0) if session[:history].size >= 5
    #   session[:history] << request.url
    # end

    def check_depth_limit
      Rails.logger.error("Entrou no check_depth_limit")
      if params[:parent_id].present?
        Rails.logger.error("This is an error message")
        parent_comment = Comment.find(params[:parent_id])
        if parent_comment.depth >= 4
          flash[:danger] = "Atingida profundidade máxima de comentários (#{Setting.comment_depth_limit})."
          redirect_to article_path(parent_comment.article)
        end
      end
    end

    def check_user
      if current_user.username == "Visitante"
        flash[:danger] = "Você precisa estar logado para comentar."
        redirect_to article_path(id: params[:article_id])
      end
    end

    def comment_params
      params.require(:comment).permit(:title, :content, :parent_id, :article_id)
    end
end
