class CategoriesController < ApplicationController

  def new
    @category = Category.new
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
