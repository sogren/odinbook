Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations",
      sessions: "sessions", omniauth_callbacks: "users/omniauth_callbacks" }

  resources :posts, only: [:new, :create]
  resources :users, only: [:create, :show] do
    resource :profile, only: [:show]
    resources :posts, only: [:show]
  end
  resources :likes, only: [:create]
  resources :comments, only: [:new, :create]

  root "static_pages#home"

  get "all_users" => "users#all_users", as: "all_users"
  get "more_comments/:post_id/:comment_page" => "comments#more_comments"
  get "people" => "users#people", as: "people"

  get "friends/:id" => "users#friends", as: "friends"

  get "timeline/:id" => "users#timeline", as: "timeline"

  post "invitations/send_invite" => "invitations#send_invite", as: "send_invite"
  post "invitations/decline_invite" => "invitations#decline_invite", as: "decline_invite"
  delete "invitations/remove_invite" => "invitations#remove_invite", as: "remove_invite"

  post "friends_relations/make_friend" => "friends_relations#make_friend", as: "make_friend"
  delete "friends_relations/destroy" => "friends_relations#destroy", as: "remove_friend"

  delete "like" => "likes#destroy", as: "unlike"

  get "edit" => "profiles#edit", as: "edit_profile"
  put "update_profile" => "profiles#update"

  get '*unmatched_route', to: 'application#not_found'
end
