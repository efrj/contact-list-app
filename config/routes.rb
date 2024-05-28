Rails.application.routes.draw do
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :contacts, except: [:new, :edit]
      get 'search_address', to: 'contacts#search_address'
    end
  end
end
