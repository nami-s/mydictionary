class Article < ApplicationRecord

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :category
  has_many :checks, dependent: :destroy
  
  attachment :image, content_type: ["image/jpeg", "image/png", "image/gif"]

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true

end
