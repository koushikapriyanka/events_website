Rails.application.routes.draw do
  #resources :user_events, only: [:new, :create, :show] do 
#  	collection do 
#      get :event_users_details
#    end  
#  end
  root to: "events#index"
  resources :events, only: [:index] do
  	resources :user_events, only: [:index, :show, :new, :create] do
  		member do 
      	patch :cancel
    	end
  	end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
