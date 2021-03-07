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

  def sentiment
    score = self.score
    magnitude = self.magnitude
    if score == 0.0
      return '安定してきましたね！'
    elsif score >= 0.1 && magnitude < 5
      return 'その調子です！'
    elsif score >= 0.1 && magnitude >= 5
      return '良い感じです！今後も継続していきましょう！'
    elsif score <= -0.1 && magnitude < 5
      return '少し自信なさげかな？大丈夫！継続は力なり！'
    elsif score <= -0.1 && magnitude >= 5
      return 'すごく自信なさげですね。大丈夫！ここから追い上げていきましょう！'
    end
  end

end
