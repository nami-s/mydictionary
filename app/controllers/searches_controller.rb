class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @category_params = params[:q][:category_id_eq]
    @date_params = params[:q][:created_at_eq]
    @keyword_params = params[:q][:title_or_body_cont]
  end

  def search
  end

end
