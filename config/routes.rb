Rails.application.routes.draw do
  root 'pages#home'
  resources :pages do
    collection do
      get :redirect_url
      post :redirect_url
    end
  end

  resources :registrations, only: [:show, :new, :create] do
    collection do
      get :check_subscribe
    end
  end


end
