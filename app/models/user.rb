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
    friends - blocked_users - blocked_by_users
  end

  def for_dashboard_user_ids
    not_blocked_friends.uniq.collect(&:id) << id
  end

  def all_other_users
    User.where.not(id: id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friend_with?(user)
    friends.include?(user)
  end

  def blocked?(user)
    blocked_users.include?(user)
  end
end
