# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :users do
      resources :links
    end
    post 'authenticate', to: 'authentication#authenticate'
  end
  get '/:id', to: 'links#visit', as: :short
end
