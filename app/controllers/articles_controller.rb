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
    if category_params[:radio_category] == "existing_category"
      @category = Category.find(article_params[:category_id])
      @article = current_user.article.new(article_params)
      @article.category = @category
    elsif category_params[:radio_category] == "new_category"
      @category = current_user.categories.new(name: params[:name])
      @category.save
      @article = current_user.article.new(article_params)
      @article.category = @category
    end
    if @article.save
      redirect_to articles_path
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
    if @article.update(article_params)
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

  def category_params
    params.permit(:name, :radio_category)
  end

  def article_params
    params.permit(:title, :category_id, :image, :body)
  end
  # def article_params
  #   params.require(:article).permit(:title, :radio_category, :new_category, :category_id, :image, :body)
  # end

end
