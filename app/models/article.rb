class Article < ApplicationRecord

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :category
  has_many :checks, dependent: :destroy
  attachment :image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true

end
