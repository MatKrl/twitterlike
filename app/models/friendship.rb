class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id }

  after_create :create_connected_friendship
  after_destroy :destroy_connected_friendship

  private

  def create_connected_friendship
    Friendship.where(
      user_id: friend_id,
      friend_id: user_id,
      status: 'invited'
    ).first_or_create
  end

  def destroy_connected_friendship
    Friendship.where(
      user_id: friend_id,
      friend_id: user_id
    ).delete_all
  end
end
