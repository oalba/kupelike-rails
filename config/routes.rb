Rails.application.routes.draw do
  devise_for :users
  # scope "/admin" do
  #   resources :users
  # end
  scope "/api" do
    get 'get_likes/:id', to: 'api#get_likes', as: 'get_likes'
    get 'get_place/:id', to: 'api#get_place', as: 'get_place'
  end

  # resources :user
  # get 'index', to: "index#index", as: "index"
  # get "contact", to: "static_pages#contact", as: "contact"
  get 'contact', to: 'messages#contact', as: 'contact'
  post 'contact', to: 'messages#create'
  get 'register', to: 'messages#register', as: 'register'
  post 'register', to: 'messages#register_send'
  get "about_us", to: "static_pages#about_us", as: "about_us"
  get "all_maps", to: "places#maps", as: "all_maps"
  get "map/:id", to: "places#map", as: "map"
  get "search", to: "places#search", as: "search_places"
  post "votes", to: "votes#action", as: "votes_action"
  # get "places_admin", to: "places#index_admin", as: "places_admin"

  resources :places do
    resources :items
  end
  # resources :places, only: [:index, :show]

  namespace :admin do
    resources :places do
      resources :items do
        get "update_year", to: "items#update_year"
        # resources :votes
      end
    end
    resources :users
  end

  resources :clients

  # mount ActionCable.server => '/cable'
  # resources :items

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'index#index'
end
