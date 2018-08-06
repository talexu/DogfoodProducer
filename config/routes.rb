Rails.application.routes.draw do
  get 'dogfood_factory/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dogfood_factory#index'

  resources :dogfood_factory do
    collection do
      put :reset
      put :start
      post :increase
      get :status
    end
  end
end
