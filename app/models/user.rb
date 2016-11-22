class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :comments

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :by_user_blockades, class_name: 'Blockade', foreign_key: 'user_id'
  has_many :blocked_users, through: :by_user_blockades

  has_many :on_user_blockades, class_name: 'Blockade', foreign_key: 'blocked_id'
  has_many :blocked_by_users, through: :on_user_blockades, source: 'user'

  validates :email,    presence: true
  validates :username, presence: true

  def not_blocked_friends
    blocked_ids = blocked_users.pluck(:id) + blocked_by_users.pluck(:id)
    friends.where.not(id: blocked_ids)
  end

  def all_other_users
    User.where.not(id: id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friend_with?(user)
    friends.exists?(id: user.id)
  end

  def blocked?(user)
    blocked_users.exists?(id: user.id)
  end
end
