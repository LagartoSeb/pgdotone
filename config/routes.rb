Rails.application.routes.draw do

  # Create Devise routes for users, but skipping the sessions views
  devise_for :users, :skip => [:sessions]

  devise_scope :user do
    get 'login'     => 'devise/sessions#new',     :as     => :new_user_session
    post 'login'    => 'devise/sessions#create',  :as     => :user_session
    delete 'logout' => 'devise/sessions#destroy', :method => :delete
  end
  #resources :pages
  get '/servicio-cliente' => 'pages#servicio_cliente', as: 'servicio_cliente'
  get '/proceso-compra'   => 'pages#proceso_compra',   as: 'proceso_compra'
  get '/proyectos-ficha'  => 'pages#proyectos_ficha',  as: 'proyectos_ficha'
  get '/modelos-ficha'    => 'pages#modelos_ficha',    as: 'modelos_ficha'
  get '/quienes-somos'    => 'pages#quienes_somos',    as: 'quienes_somos'
  get '/financiamiento'   => 'pages#financiamiento'
  get '/proyectos'        => 'pages#proyectos'
  get '/contacto'         => 'pages#contacto'

  get '/admin'            => 'admin#index'
  root 'pages#index'
end
