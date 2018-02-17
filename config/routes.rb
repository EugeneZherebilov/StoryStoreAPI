Rails.application.routes.draw do
  # Registration & Authentication
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations:      'users/registrations',
      sessions:           'users/sessions',
      token_validations:  'users/token_validations',
      passwords:          'users/passwords'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Game & Game messages
      resources :games do
        resources :messages, except: :show
      end

      #Search
      get 'search_users', to: 'search#find_users'

    end
  end

end
