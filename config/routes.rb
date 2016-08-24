Rails.application.routes.draw do
  root 'sessions#new'
  resource :session, controller: "sessions", only: [:create]
  resources :helps, controller: "helps", only: [:index]

  get "/sign_in" => "sessions#new", as: "sign_in"
  get "/sign_out" => "sessions#destroy", as: "sign_out"
  mount AirlineApi => '/api'

  # resources :users, controller: "users", only: [:create]
  # get "/edit_password" => "users#edit_password", as: "edit_password"
  # post "/update_password" => "users#update_password", as: "update_password"
  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'users#new', as: 'sign_up'
  end

  resources :users do
    collection do
      get "edit_password"
      post "update_password"
      get "avatar_upload"
      post "upload_avatar"
    end
  end
  

  # get "/cities" => "cities#index", as: "cities"
  # get "/update_is_open" => "cities#update_is_open", as: "update_is_open"
  resources :cities do 
    collection do
      get "index"
      get "update_is_open"
    end
  end

  get 'cities/:id/move_position/:type' => 'cities#move_position'
end
