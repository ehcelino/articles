class CommentsController < ApplicationController
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # before_action :set_article, only: [:new, :create]
  before_action :check_depth_limit, only: [:new, :create]
  before_action :check_user, only: [:new, :create]
  

  def new
    @comment = Comment.new
    if params[:article_id]
      @article = Article.find(params[:article_id])
      session[:article_id] = @article.id
    end
    if !params[:parent_id].nil?
      @parent_comment = Comment.find(params[:parent_id])
      session[:parent_id] = @parent_comment.id
      @parent_id = @parent_comment.id
    elsif !params[:comment].nil? && params[:comment][:parent_id] != ""
      session[:parent_id] = params[:comment][:parent_id]
      @parent_comment = Comment.find(params[:comment][:parent_id])
      @parent_id = @parent_comment.id
    else
      session[:parent_id] = nil
    end
  end

  def create
    Rails.logger.error("Entrou no create")
    @comment = Comment.new(comment_params)
    @article_id = session[:article_id]
    # Para listar os comentários
    @article = Article.find(@article_id)
    @comments = @article.comments.roots
    # ################
    if !session[:parent_id].nil?
      @parent_id = session[:parent_id]
      @parent_comment = Comment.find(session[:parent_id])
    elsif !params[:comment].nil?
      if params[:comment][:parent_id] != ""
        session[:parent_id] = params[:comment][:parent_id]
        @parent_id = session[:parent_id]
        @parent_comment = Comment.find(params[:comment][:parent_id])
      end
    end
    set_depth
    # @comment.article = @article
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { flash[:success] = "Comentário criado!"
          redirect_to article_path(params[:comment][:article_id]) }
        
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update('comment_frame', '<div></div>'),
            turbo_stream.update("view_comments", partial: "articles/view_comments", locals: { comments: @comments })]
          end
        
      else
        format.html { flash[:danger] = "Erro na criação do comentário."
          render :new, status: :unprocessable_entity, content_type: "text/html" }
        # flash[:danger] = "Erro no preenchimento."
        # render turbo_stream: [turbo_stream.replace("#{@parent_comment}", 'comments#new')]
        
        

        # format.turbo_stream { turbo_stream.replace('error_stream', partial: 'error', locals: { comments: @comments }) }
      end
    end
  end

  # def com
  #   @comment = Comment.new
  #   if params[:article_id]
  #     @article = Article.find(params[:article_id])
  #     session[:article_id] = @article.id
  #   end
  #   if params[:parent_id]
  #     @parent_comment = Comment.find(params[:parent_id])
  #     session[:parent_id] = @parent_comment.id
  #   end
  # end

  def update
    set_depth
    if @comment.update(comment_params)
      redirect_to @comment.article, notice: 'Comentário modificado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.article, notice: 'Comentário apagado com sucesso.'
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
        if parent_comment.depth >= Setting.comment_depth_limit
          render turbo_stream: [turbo_stream.update("#{helpers.dom_id(parent_comment)}", "<div>Atenção: atingida profundidade máxima de comentários (#{Setting.comment_depth_limit}).</div>")]
          # flash[:danger] = "Atingida profundidade máxima de comentários (#{Setting.comment_depth_limit})."
          # redirect_to article_path(parent_comment.article)
        end
      end
    end

    def check_user
      if current_user.username == "Visitante"
        # flash[:danger] = "Você precisa estar logado para comentar."
        # redirect_to article_url(id: params[:article_id])
        render turbo_stream: [turbo_stream.update('log_message', '<div>Você precisa estar logado para comentar.</div>')]
      end
    end

    def comment_params
      params.require(:comment).permit(:title, :content, :parent_id, :article_id)
    end

    

end
