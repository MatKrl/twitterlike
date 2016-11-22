class Message < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :user_id, :content, presence: true

  def self.created_by(user_ids)
    Message.includes(:user, comments: :user)
           .where(messages: { user_id: user_ids })
           .order('messages.created_at DESC')
  end
end
