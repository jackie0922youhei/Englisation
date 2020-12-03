Rails.application.routes.draw do

  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }

  devise_for :customers, controllers: {
  sessions: 'customers/sessions',
  registrations: 'customers/registrations'
  }

  namespace :customers do
    get 'comments/create'
    get 'comments/destroy'
    get 'comments/edit'
    get 'comments/update'
  end
  namespace :customers do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :customers do
    get 'reviews/create'
    get 'reviews/edit'
    get 'reviews/update'
    get 'reviews/destroy'
  end
  namespace :customers do
    get 'posts/index'
    get 'posts/new'
    get 'posts/create'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
  end
  root 'customers/posts#index'
  get 'homes/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
