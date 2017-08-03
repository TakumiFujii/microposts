class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private 
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  #def counts(user)
  #  @count_microposts = user.microposts.count
  #  @count_followings = user.followings.count
  #  @count_followers = user.followers.count
  #end
  
   #def counts(user)
   # @count_microposts = user.microposts.count
   # @count_favorite_microposts = user.favorite_microposts.count
   #end
   #上間違えてた、二重でしたらあかんから、あとでじっくり考える。
   
   def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorite_microposts = user.favorite_microposts.count
  end
end
