module ArticlesHelper
  def truncate_title(title)
    title = strip_tags(title).truncate(9)
  end
  
end
