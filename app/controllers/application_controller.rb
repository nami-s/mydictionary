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
    @p = current_user.article.ransack(params[:q])
    @results = @p.result.page(params[:page]).per(15).order(" created_at DESC ")
    @categories = current_user.categories.all
  end

end
