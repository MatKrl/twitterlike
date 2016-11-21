class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
end
