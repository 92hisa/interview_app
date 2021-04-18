class CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "登録されました"
      redirect_to categories_path
    else
      flash[:alert] = "登録できませんでした"
      render 'index'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "編集が完了しました"
      redirect_to categories_path
    else
      flash[:alert] = "編集できませんでした"
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
