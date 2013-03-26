Tempusfugit::Application.routes.draw do

  # routing macros from devise for our user class
  devise_for :users

  # static pages handled by a single controller pages
  get 'welcome' => 'pages#welcome', as: :welcome
  get 'about' => 'pages#about', as: :about
  get 'contact' => 'pages#contact', as: :contact
  get 'faq' => 'pages#faq', as: :faq
  get 'terms' => 'pages#terms', as: :terms
  get 'tour' => 'pages#tour', as: :tour

  # a growing list of reports for admins only
  get "reports" => 'reports#index', as: :reports
  get "reports/project_summary" => 'reports#project_summary', as: :report_project_summary
  get "reports/user_project_detail" => 'reports#user_project_detail', as: :report_user_project_detail

  # resource routes for major models
  resources :users
  resources :clients
  resources :projects
  resources :spans

  # because devise allows users to manage some things on their own
  # I wand to put users in a special name space for administration
  namespace :admin do
    resources :users # Have the admin manage them here.
  end

  # You can have the root of your site routed with "root"
  root to: 'pages#welcome'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
