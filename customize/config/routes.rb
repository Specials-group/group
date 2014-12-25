Customize::Application.routes.draw do
  root to: "dishes#top"
  get "dishes/index"
  put 'orders/:id' => "orders#create"
  resources :dishes do
    collection { get "top" }
    collection { get "search" }
    member { get "order" }
  end
 
  resource :session, only: [:create, :destroy]

  resource :account, only: [:edit, :update]

  resources :orders, except: [:edit, :update] do
    collection { post "check" }
  end

  namespace :admin do
    root to: "reserves#index"
    resources :reserves, except: [:new, :create]
    resources :stocks, only: [:edit, :update, :index] do
      collection { get "index_all" }
      collection { get "show_date" }
    end
    resources :dishes do
      collection { get "search" }
    end
    resources :members, only: [:index, :show]
  end

  match ':controller(/:action(/:id))(.:format)'


end
