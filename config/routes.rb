Rails.application.routes.draw do

  get 'checkout', to: 'checkout#show'
  post 'confirm_payment', to: 'checkout#confirm_payment'


  devise_for :users


  get "up" => "rails/health#show", as: :rails_health_check

  root "videogames#index"


  resources :videogames do
    resources :bookings, only: [:new, :create]
  end


  resources :bookings, only: [:index, :destroy] do
    member do
      patch :accept
      patch :reject
    end
  end


  resource :profile, only: [:edit, :update]


  get "/my_videogames", to: "videogames#my_videogames"


  get 'contact', to: 'pages#contact'
end
