module SearchesHelper
  def search_product
    # 改行、半角全角スペースで区切られた箇所をハッシュにしている
    # Parameters: {"q"=>{"sorts"=>"id asc", "created_at_eq"=>"", "category_id_eq"=>"12", "title_or_body_cont"=>""}, "commit"=>" 検索 "}
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
