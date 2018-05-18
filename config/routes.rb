Rails.application.routes.draw do

  # mount PgHero::Engine, at: "pghero"

  namespace :api do
    namespace :v1 do
      post 'user_token'     => 'user_token#create'
      get 'aids/detail/:aid_slug'   => 'api_aides#detail'
      get 'aids/eligible'   => 'api_aides#eligible'
      get 'aids/ineligible' => 'api_aides#ineligible'
      get 'aids/uncertain'  => 'api_aides#uncertain'
    end
  end


  namespace :stats do
    root 'stats#index'
    get '/index' => 'stats#index'
  end


  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)

  root 'welcome#index'

  namespace :admin do
    resources :users
    resources :aids
    resources :rules do 
      get 'resolve', on: :member
      post 'save_simulation', on: :member
      delete 'delete_simulation', on: :member
    end
    controller 'pages' do
      get 'stats'
      get 'rename'
      get 'archive'
      get 'loadrefdata'
      post 'rename_eligible_value'
      post 'archive_all_aids'
      post 'unarchive_all_aids'
      post 'load_ref_data'
      post 'load_stats'
      post 'load_stats_from_pe'
    end
    resources :variables
    resources :contract_types
    resources :rule_checks
    root to: "aids#index"
  end

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  get '/auth/google_oauth2', as: :google_oauth

  # a route to check exception are propertly sent
  resources :divide_by_zero,         only: [:index]

  resources :age_questions,         only: [:new, :create]
  resources :address_questions,     only: [:new, :create]
  resources :allocation_questions,  only: [:new, :create]
  resources :category_questions,    only: [:new, :create]
  resources :grade_questions,       only: [:new, :create]
  resources :inscription_questions, only: [:new, :create]
  resources :are_questions,         only: [:new, :create]
  resources :other_questions,       only: [:new, :create]

  # resources :aides, only: [:show, :index] 
  resources :aides, only: [:index] do
    collection do
      resources :type, only: [:show]
      resources :detail, only: [:show]
    end
  end

  match 'go_back' => 'go_back#go', :via => [:post], :as => 'go_back'

  get 'conditions-generales-d-utilisation', to: 'welcome#terms'
  get 'welcome/index'
  post 'welcome/start_wizard'
  get '/expire_welcome_page', to: 'welcome#expire_welcome_page'
  
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'sitemap.xml', :to => 'sitemap#index', :as => 'main_sitemap'
  get 'aides-sitemap.xml', :to => 'sitemap#aides', :as => 'aides_sitemap'
  get 'types-aides-sitemap.xml', :to => 'sitemap#types', :as => 'types_sitemap'


  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

end
