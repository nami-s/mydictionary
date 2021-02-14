class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    User.find_by(isguest: true).categories.delete_all
    User.find_by(isguest: true).articles.delete_all
    p "投稿を全て削除しました"
  end
end