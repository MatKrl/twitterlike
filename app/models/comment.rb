class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message

  validates :user_id, :message_id, :content, presence: true
end
