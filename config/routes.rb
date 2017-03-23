Rails.application.routes.draw do
  devise_for :users
  # scope "/admin" do
  #   resources :users
  # end

  # resources :user
  # get 'index', to: "index#index", as: "index"
  # get "contact", to: "static_pages#contact", as: "contact"
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
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
      resources :items
    end
    resources :users
  end

  # namespace :admin do
  #   resources :items
  # end

  # resources :index do
  #   resources :place
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'index#index'
end
