class SearchesController < ApplicationController
  before_action :search_product, only: [:index, :search]

  def index
  end


  def search
  end

  private

  def search_product
    @p = Article.ransack(params[:q])
    @results = @p.result
    @categories = Category.all
  end
end
