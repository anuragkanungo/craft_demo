class Tweet < ApplicationRecord
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  default_scope -> { order(created_at: :desc) }
  validates :message, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  self.per_page = 100
end
