class Micropost < ApplicationRecord
  belongs_to :user
  #User と Micropost の一対多を表現しています。このコードのおかげで、micropost.user とすると、
  #この micropost インスタンスを持っている User を取得することができます。
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }

end
