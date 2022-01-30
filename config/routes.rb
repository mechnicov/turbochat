Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :rooms, only: %i[show create], param: :title
  resources :messages, only: :create
  root "rooms#index"
end
