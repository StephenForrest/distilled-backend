# frozen_string_literal: true

Rails.application.routes.draw do
  get '/health', to: proc { [200, {}, ['success']] }

  post '/execute', to: 'graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
