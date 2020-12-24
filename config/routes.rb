Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations',
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end

  scope module: :customers do
    resources :customers, only: [:index] do
      resource :relationships, only: [:create, :destroy]
      member do
        get :follows, :followers
      end
    end
    get '/:id/edit' => 'customers#edit', as: 'edit_mypage'
    patch '/:id/update' => 'customers#update', as: 'update_mypage'
    get '/:id/mypage' => 'customers#show', as: 'mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'
    resources :posts, only: [:create, :update, :destroy, :show] do
      resources :comments, only: [:create, :edit, :update, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :reviews, only: [:create, :edit, :update, :destroy]
    end
    resources :notifications, only: [:index] do
      collection do
        delete :destroy_all
      end
    end
    resources :rooms, only: [:index, :show, :create, :destroy]
  end

  get 'homes/about'
  root 'customers/posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
