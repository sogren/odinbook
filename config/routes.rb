Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :posts, only: [:new, :create, :show]
  resources :users, only: [:create, :show] do
    resource :profile, only: [:show]
  end
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:new, :create]

root "static_pages#home"

get "people" => "static_pages#people", as: "people"

get "friends/:id" => "static_pages#friends", as: "friends"

get "timeline/:id" => "static_pages#timeline", as: "timeline"

post "invitations/send_invite" => "invitations#send_invite", as: "send_invite"
post "invitations/decline_invite" => "invitations#decline_invite", as: "decline_invite"
delete "invitations/remove_invite" => "invitations#remove_invite", as: "remove_invite"

post "friends_relations/make_friend" => "friends_relations#make_friend", as: "make_friend"
delete "friends_relations/destroy" => "friends_relations#destroy", as: "remove_friend"

get "edit" => "profiles#edit", as: "edit_profile"
patch "update_profile" => "profiles#update"

get '*unmatched_route', to: 'application#not_found'

#post "likes/create" => "likes#create", as: "like"
#post "likes/destroy" => "likes#destroy", as: "unlike"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
