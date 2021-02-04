class Category < ApplicationRecord

  belongs_to :user
  has_many :articles, dependent: :destroy

end
