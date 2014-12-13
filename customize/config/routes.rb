Customize::Application.routes.draw do
  root to: "dishes#index"
  get "dishes/index"

  resources :dishes do
    collection { get "search" }
  end
 
  resource :session, only: [:create, :destroy]

  resource :account, except: [:index, :show, :destroy] do
    member { get "check" }  #??
  end

  resources :orders, except: [:edit, :update] do
    member { get "check" }
  end

  namespace :admin do
    root to: "reserves#index"
    resources :reserves, except: [:new, :create]
    resources :stocks, only: [:edit, :update]
    resources :dishes do
      collection { get "search" }
    end
    resources :members, only: [:index, :show]
  end

end
