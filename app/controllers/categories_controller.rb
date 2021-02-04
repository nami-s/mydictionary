class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path
    else
      @categories = Category.all
      render 'index'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
