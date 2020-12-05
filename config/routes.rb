Rails.application.routes.draw do

  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  devise_for :customers, controllers: {
  sessions: 'customers/sessions',
  registrations: 'customers/registrations'
  }

  scope module: :customers do
    get '/:id/edit' => 'customers#edit', as: 'edit_mypage'
    patch '/:id/update' => 'customers#update', as: 'update_mypage'
    get '/:id/mypage' => 'customers#show', as: 'mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'
    resources :posts do
      resources :comments, only: [:create, :edit, :update, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :reviews, only: [:create, :edit, :update, :destroy]
    end
    resources :notifications, only: [:index] do
      collection do
        delete :destroy_all
      end
    end
  end
  get 'homes/about'
  root 'customers/posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
