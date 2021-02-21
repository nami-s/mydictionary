class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_product, if: :current_user

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def search_product
    # 改行、半角全角スペースで区切られた箇所をハッシュにしている
    words = params[:q].delete(:title_or_body_cont) if params[:q].present?
    if words.present?
      params[:q][:groupings] = []
      words.split(/[\f\n\r\t\v 　]/).each_with_index do |word, i|
        params[:q][:groupings][i] = { title_or_body_cont: word }
      end
    end
    @search = current_user.articles.ransack(params[:q])
    @results = @search.result.page(params[:page]).per(15).order(" created_at DESC ")
    @categories = current_user.categories.all
  end

end
