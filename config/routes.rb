Rails.application.routes.draw do

  get 'login' => "users#login_form"
  post 'login' => "users#login"

  post 'logout' => "users#logout"

  get 'users/index'
  get 'users/show/:id' => "users#show"
  get 'users/signup' => "users#signup"
  post 'users/create' => "users#create"

  get 'users/:id/edit' => "users#edit"
  patch 'users/:id' => "users#update"

  post 'users/:id/delete' => "users#delete"

  get "/" => "home#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
