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
    @article = Article.new(article_params)
    @article.user_id = current_user.id
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

  def article_params
    params.require(:article).permit(:title, :category_id, :image, :body)
  end


end
