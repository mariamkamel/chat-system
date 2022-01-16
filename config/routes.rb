Rails.application.routes.draw do
  namespace :api do
    resources :applications, param: :token, only: [:index, :show, :create] do
      resources :chats, param: :number, only: [:show, :create] do
        resources :message, only: [:show, :create]
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
