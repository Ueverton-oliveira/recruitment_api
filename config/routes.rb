Rails.application.routes.draw do
  devise_for :recruiters
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
    end
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
