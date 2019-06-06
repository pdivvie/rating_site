Rails.application.routes.draw do
  
  resources :categories
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_up: 'register', sign_out: 'logout'}

  get 'my-services', to: 'businesses#my_services'
  
  resources :locations do
    resources :businesses do
      resources :ratings, except: :index
    end
  end

  get 'ratings' => 'ratings#index', as: :ratings

  root to: 'pages#home'
end
