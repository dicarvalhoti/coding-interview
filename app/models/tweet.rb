class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 140 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :before_time, ->(time) { where("created_at < ?", time) }
 
end
