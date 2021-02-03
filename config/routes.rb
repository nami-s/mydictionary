Rails.application.routes.draw do

  get 'search' => 'searches#search'
  root to: 'homes#top'
  devise_for :users
  resources :articles do
    resources :checks, only: [:create, :destroy]
  end
  resources :categories

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
