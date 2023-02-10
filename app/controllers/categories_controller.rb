class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end


  # def index
  #   page = params[:page] || 1
  #   @per_page = Setting.per_page
  #   offset = (page.to_i - 1) * @per_page
  #   @articles = Article.where(category: params[:id]).offset(offset).limit(@per_page).order(created_at: :desc)
  #   # offset = número de registros para pular antes de começar a extrair dados
  #   # limit = máximo número de registros 
  #   # enquanto o offset indica de onde começa, o limit termina.
  #   # @articles = Article.all
  #   # @comments = Comment.all
  #   @actual = params[:page] || 1
  # end


  def index
    page = params[:page] || 1
    @per_page = Setting.per_page
    offset = (page.to_i - 1) * @per_page
    @articles_count = Article.where(category: params[:id]).count
    @articles = Article.where(category: params[:id]).offset(offset).limit(@per_page).order(created_at: :desc)
    # @articles = Article.all
    # @comments = Comment.all
    @actual = params[:page] || 1
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoria criada com sucesso."
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
