class ChecksController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @article.user_id = current_user.id
    @check = Check.new
    @check.article_id = params[:article_id]
    @check.user_id = current_user.id
    @check.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.user_id = current_user.id
    @check = Check.find(params[:article_id])
    @check.destroy
    redirect_to article_path(@article)
  end
end
