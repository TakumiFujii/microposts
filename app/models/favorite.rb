class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  #両方最低でもidだけは持っといてな、、、
end
