class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  
  has_many :relationships
  has_many :microposts
  
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  #お気に入りのやつ
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

  def put_favorite(micropost)
    Favorite.find_or_create_by(micropost_id: micropost.id, user_id: self.id)
  end
  
  def unput_favorite(micropost)
    favorite = Favorite.find_by(micropost_id: micropost.id, user_id: self.id)
    #これと同じ favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end

  def put_favorite_yet?(micropost)
    self.favorite_microposts.include?(micropost)
  end
end
#{"filter":false,"title":"user.rb","tooltip":"/microposts/app/models/user.rb","undoManager":{"mark":-1,"position":-1,"stack":[]},"ace":{"folds":[],"scrolltop":180,"scrollleft":0,"selection":{"start":{"row":6,"column":21},"end":{"row":6,"column":21},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1501753586475,"hash":"e2cd7ac23144cc0dc475139738fd1182e6e943c8"}