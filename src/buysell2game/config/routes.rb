Rails.application.routes.draw do
  
  devise_for :users
  root to: "pages#home"
  get "/restricted", to: "pages#restricted"
  get "listings/:id", to: "listings#index", as: "listings"

  get "listing/:id", to: "listings#show", as: "listing"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
