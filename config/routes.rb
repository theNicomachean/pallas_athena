Rails.application.routes.draw do
  resources :courses
  resources :advisors
  resources :students do
    resources :academic_plans
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
