class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.all.page(params[:page]).per(15).order(" created_at DESC ")
    @categories = current_user.categories.all
  end

  def new
    @article = Article.new
    @categories = current_user.categories.all
  end

  def create
    language = Language.get_data(article_params[:body])
    if article_params[:radio_category] == "existing_category"
      params_update = article_params.except(:name, :radio_category)
      if article_params[:category_id]
        @category = Category.find(article_params[:category_id])
        @article = current_user.articles.new(params_update)
        @article.category = @category
      else
        @article = current_user.articles.new(params_update)
      end
    elsif article_params[:radio_category] == "new_category"
      params_update = article_params.except(:category_id, :radio_category, :name)
      @category = current_user.categories.new(name: article_params[:name])
      @category.save
      @article = current_user.articles.new(params_update)
      @article.category = @category
    end
    @article.score = language['score']
    @article.magnitude = language['magnitude']
    if @article.save
      redirect_to article_path(@article)
    else
      @categories = current_user.categories.all
      render 'new'
    end
  end

  def show
    @article = current_user.articles.find(params[:id])
  end

  def edit
    @article = current_user.articles.find(params[:id])
    @categories = current_user.categories.all
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
    if article_params[:radio_image] == "remove_image"
      params_update[:remove_image] = 1
    end
    params_update = params_update.except(:radio_image)
    if @article.update_attributes(params_update)
      redirect_to article_path(@article)
    else
      @categories = current_user.categories.all
      render "edit"
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :category_id, :name, :radio_category, :image, :body, :remove_image, :radio_image)
  end

end
