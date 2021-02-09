class ChecksController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = current_user.article.find(params[:article_id])
    @check = Check.new
    @check.article_id = params[:article_id]
    @check.user_id = current_user.id
    @check.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = current_user.article.find(params[:id])
    @check = current_user.checks.find(params[:article_id])
    @check.destroy
    redirect_to article_path(@article)
  end
end
