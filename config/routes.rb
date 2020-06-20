# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#new'

  resources :users
  resources :questions
  resources :awnsers
end
