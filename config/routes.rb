Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations" } # sessions: "sessions",

  resources :rooms, only: %i[show create], param: :title
  resources :users, only: :show, as: :account
  resources :messages, only: :create do
    member { post :like }
  end
  root "rooms#index"
end
