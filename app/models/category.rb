class Category < ApplicationRecord

  belongs_to :user
  has_many :articles, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }

end
