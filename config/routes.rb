Rails.application.routes.draw do

  scope 'dogfood' do
    # get 'factory/index'
    # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # root 'factory#index'

    resources :factory do
      collection do
        put :reset
        put :start
        post :increase
        post :jump
        get :status
      end
    end
  end

  get '/dogfood/admin', to: 'factory#admin'
  get '/healthies/check', to: 'application#health_check'
end
