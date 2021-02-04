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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :category_id, :image, :body)
  end


end
