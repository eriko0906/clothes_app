class User < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :pw,{presence: true}
  validates :nickname,{presence: true}
  has_one_attached :image
end
