Placements::Application.routes.draw do
  resources :clients, only: [:new, :create, :show] do
  	resources :sites, only: [:new, :create, :show]
  end
end
