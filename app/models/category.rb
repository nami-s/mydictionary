class Category < ApplicationRecord

  belongs_to :user
  has_many :articles, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 20 }

end
