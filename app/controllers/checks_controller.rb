class ChecksController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = current_user.articles.find(params[:article_id])
    @check = Check.new
    @check.article_id = params[:article_id]
    @check.user_id = current_user.id
    @check.save
  end

  def destroy
    @article = current_user.articles.find(params[:article_id])
    @check = current_user.checks.find_by(id: params[:id], article_id: params[:article_id])
    @check.destroy
  end
end
