Rails.application.routes.draw do
  root to: 'pages#index'

  resources :sessions, :registrations
  resources :pages, :video_posts, :video_comments, :tags

  scope module: 'authorize' do
    resources :post_videos
    resources :approves
    resources :profiles
    resources :communities
    resources :upvotes
    resources :favorites
  end
end
