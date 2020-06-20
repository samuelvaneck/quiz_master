# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#new'

  resources :users
  resources :questions do
    resources :awnsers
  end

  # custom routes
  get '/users/:id/quiz_question', to: 'users#quiz_question', as: 'user_quiz_question'
  post '/users/:id/quiz_awnser', to: 'users#quiz_awnser', as: 'user_quiz_awnser'
  get '/users/:id/quiz_result', to: 'users#quiz_result', as: 'user_quiz_result'
end
