Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :recruiter do
        resources :recruiters
        resources :jobs
      end

      namespace :public do
        resources :jobs, only: [:index, :show]
        resources :submissions, only: [:create]
      end

      post 'auth/login', to: 'authentication#login'
      delete 'auth/logout', to: 'authentication#logout'
    end
  end
end
