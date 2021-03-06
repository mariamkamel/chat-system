Rails.application.routes.draw do
  namespace :api do
    resources :applications, param: :token, only: [:index, :show, :create, :update] do
      resources :chats,param: :number, only: [:index, :create] do
        resources :messages, param: :query,  only: [:index, :create, :update]
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
