WorkPlace::Application.routes.draw do
  devise_for :users

  match "/choose_flow" => "pages#choose_flow", :as => :choose_flow
  
  root :to => "pages#home"
end
