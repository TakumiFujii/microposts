Rails.application.routes.draw do
  
  #ログイン機能のやつ
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #resources :users, only: [:new, :create, :destroy]って書いてもok

  #トップページ
  root to: "toppages#index"
  
  #ユーザ登録のやつ
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  
  
  #投稿のやつ
  resources :microposts, only: [:create, :destroy]
  
  #フォロー/フォロー解除のやつ
  resources :relationships, only: [:create, :destroy]
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
    
    
  end

end
