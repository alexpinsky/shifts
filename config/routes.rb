Shifts::Application.routes.draw do
  devise_for :users

  match "/choose_flow" => "pages#choose_flow", :as => :choose_flow

  resources :work_places do
    resources :roles
    resources :shifts
  	resources :users do
  		resources :shifts
  	end
  end
  
  root :to => "pages#home"
end
