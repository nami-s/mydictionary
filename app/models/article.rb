class Article < ApplicationRecord

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :category
  has_many :checks, dependent: :destroy
  attachment :image, content_type: ["image/jpeg", "image/png", "image/gif"] # 画像ファイルのみ選別。Refileのヘルパー
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true


  # ransacker :check_count do
  #   query = '(SELECT COUNT(checks.article_id) FROM checks where checks.article_id = article.id GROUP BY checks.article_id)'
  #   Arel.sql(query)
  # end

end
