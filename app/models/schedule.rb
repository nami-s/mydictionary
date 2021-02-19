class Schedule < ApplicationRecord

  belongs_to :user
  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validate :start_finish_check

  def start_finish_check
    if self.start
      errors.add(:base, "Please select a time later than the start time") if self.start > self.end
    end
  end

end
