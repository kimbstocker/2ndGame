Rails.application.routes.draw do
  
  devise_for :users
  root to: "pages#home"
  get "/restricted", to: "pages#restricted"
  get "listings", to: "listings#index", as: "listings"
  get "listings/category/:id", to: "listings#index", as: "listings_category"
  post "listings", to: "listings#create"
  get "listings/new", to: "listings#new", as: "new_listing"
  get "listings/:id", to: "listings#show", as: "listing"
  put "listings/:id", to: "listings#update"
  patch "listings/:id", to: "listings#update"
  delete "listings/:id", to: "listings#destroy", as: "delete_listing"
  get "listings/:id/edit", to: "listings#edit", as: "edit_listing"
  post "orders", to: "orders#create"
  get "orders/new", to: "orders#new", as: "new_order"
  get "orders/:id", to: "orders#show", as: "order"
  post "items", to: "items#create"
  get "items/new", to: "items#new", as: "new_item"
  delete "items/:id", to: "items#destroy", as: "delete_item"




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
