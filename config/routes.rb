Shifts::Application.routes.draw do
  devise_for :users

  get "/choose_flow" => "pages#choose_flow", :as => :choose_flow
  get "/ron_and_neta" => "pages#wedding", :as => :ron_and_neta

  resources :workplaces do
    resources :roles
    resources :shifts
  	resources :users do
  		resources :shifts
  	end
  end
  
  root :to => "pages#home"
end
