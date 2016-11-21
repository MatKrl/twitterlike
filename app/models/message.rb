class Message < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :user_id, :content, presence: true
end
