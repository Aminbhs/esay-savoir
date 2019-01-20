Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root to: 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :clients, only: [ :index, :show, :update, :create, :destroy] do
        collection do
          get 'get_clients_by_formation'
        end
      end

      resources :formations, only: [ :index, :show, :update, :create, :destroy]
      resources :reservations, only: [ :index, :show, :update, :create, :destroy] do
      collection do
          delete 'delete_by_client_and_formation_id'
      end
    end
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
