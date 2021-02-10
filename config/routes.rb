Rails.application.routes.draw do

  get 'search' => 'searches#search'
  get 'searches' => 'searches#index'
  root to: 'homes#top'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :articles do
    resources :checks, only: [:create, :destroy]
  end
  resources :categories

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
