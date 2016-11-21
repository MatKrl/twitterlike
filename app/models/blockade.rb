class Blockade < ApplicationRecord
  belongs_to :user
  belongs_to :blocked_user, class_name: 'User', foreign_key: 'blocked_id'
end
