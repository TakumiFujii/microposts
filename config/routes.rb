Rails.application.routes.draw do
  
  #データベースにテーブルがあるかないかで表記方法変える！
  #要するにテーブルあるならresource使えてないならget "a", to コントローラ名#アクション名　ってやること。
  #下の解説にもよく目を通すこと。
  
  #
  # to: に書いてある内容
  # コントローラー名#アクション名に飛ばしてるよ
  #絶対この名前のコントローラーがあるよ。
  
  
  #ログイン機能のやつ(テーブルないからresources使ってない)
  #ログインのnewとかcreateとかdestroyとか意味わからんやん,テーブルがないから
  #やから個別に作成してるイメージ
  #↓その作り方
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #resources :users, only: [:new, :create, :destroy]って書いてもok

  #トップページ urlの直下
  root to: "toppages#index" 
  
  #ユーザ登録のやつ/フォローのやつも足してる
  
  
  # リソースが持っているアクション（処理・意味）
  
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :put_favorite
      #お気に入りのメンバーはuser"の"member"の"likes(お気に入りに追加したuser)に設定する
      #全体のuserからmemberで更に深掘りしてるってことやな。
      #こいつら二つインデント進んでるやろ？これは単純にuser/x/の更に奥に入ってるってこと！
      #routesではこうやってインデントも奥行きを示している！
    end
  end
  
  # /users/1/edit
  # /users/1/followings(members do使って奥に入ってる)
  # /users/1/followers

  # users とか「リソース」=「概念」
  # / を「の」で置き換えて読む
  # 「ユーザー」「の」「1番さん」「の」「フォロー一覧」
  
  
  #投稿のやつ
  resources :microposts, only: [:create, :destroy]
  
  #お気に入りのrootingしていこう。
  resources :favorites, only: [:create, :destroy]
  
  #フォロー/フォロー解除のやつ
  resources :relationshps, only: [:create, :destroy]
  
  
  
  
  
  # 何をどう書いたとしても
  # google.com/xxx/yyy
  #インデントしてないんやったらxxxに入って、id要求してるやつとかmemberで深堀り(インデント)してるやつは
  #yyとかその奥に行く
  #showとかrails routesでみるとidって隣に書いてるからuser/idまで行くそこからフォロワーとかで
  #もっと行きたいんやったらmember使って深堀りする！
    
    
  

end
