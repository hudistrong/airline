Rails.application.routes.draw do
  resource :session, controller: "sessions", only: [:create]
  resources :cities, controller: "cities", only: [:index]
  resources :users, controller: "users", only: [:create] 

  get "/sign_in" => "sessions#new", as: "sign_in"
  get "/sign_out" => "sessions#destroy", as: "sign_out"
  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'users#new', as: 'sign_up'
  end
  root 'sessions#new'
  get "/edit_password" => "users#edit_password", as: "edit_password"
  post "/update_password" => "users#update_password", as: "update_password"
  get "/cities/update_is_open" => "cities#update_is_open", as: "update_is_open"
end
