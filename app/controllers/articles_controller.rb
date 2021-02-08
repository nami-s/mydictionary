class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all
    @categories = Category.all
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    if article_params[:radio_category] == "existing_category"
      params_update = article_params.except(:name, :radio_category)
      @category = Category.find(article_params[:category_id])
      @article = current_user.article.new(params_update)
      @article.category = @category
    elsif article_params[:radio_category] == "new_category"
      params_update = article_params.except(:category_id, :radio_category, :name)
      @category = current_user.categories.new(name: article_params[:name])
      @category.save
      @article = current_user.article.new(params_update)
      @article.category = @category
    end
    if @article.save
      redirect_to article_path(@article)
    else
      @categories = Category.all
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    @article.user_id = current_user.id
    @checks = Check.where(article_id: @article.id)
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def update
    @article = Article.find(params[:id])
    if article_params[:radio_category] == "existing_category"
      params_update = article_params.except(:radio_category, :name)
      @category = Category.find(article_params[:category_id])
      @article.category = @category
    elsif article_params[:radio_category] == "new_category"
      params_update = article_params.except(:category_id, :radio_category, :name)
      @category = current_user.categories.new(name: article_params[:name])
      @category.save
      @article.category = @category
    end
    if @article.update_attributes(params_update)
      redirect_to articles_path
    else
      @categories = Category.all
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :category_id, :name, :radio_category, :image, :body, :remove_image)
  end

end
