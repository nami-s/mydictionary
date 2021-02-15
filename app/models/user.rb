class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :schedules, dependent: :destroy

  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲストユーザー'
      user.isguest = true
    end
  end

end
