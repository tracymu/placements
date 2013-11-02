Placements::Application.routes.draw do
  resources :clients, only: [:new, :create, :show]
end
