class Article < ApplicationRecord

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :category
  has_many :checks, dependent: :delete_all
  attachment :image, content_type: ["image/jpeg", "image/png", "image/gif"] # 画像ファイルのみ選別。Refileのヘルパー
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true


  ransacker :checks_count do
    query = '(SELECT COUNT(checks.article_id) FROM checks where checks.article_id = articles.id GROUP BY checks.article_id)'
    Arel.sql(query)
  end

end
