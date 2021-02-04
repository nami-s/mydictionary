class Article < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :checks, dependent: :destroy
  attachment :image

end
