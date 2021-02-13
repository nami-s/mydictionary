class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    User.find_by(isguest: true).category.delete_all
    User.find_by(isguest: true).article.delete_all
    p "投稿を全て削除しました"
  end
end