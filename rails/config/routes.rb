Rails.application.routes.draw do

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  namespace :api do
    namespace :v1 do
      post 'api_user_token' => 'api_user_token#create'
      get 'filters'  => 'api_aides#filters'
      get 'aids/detail/:aid_slug'   => 'api_aides#detail'
      get 'aids/eligible'   => 'api_aides#eligible'
      get 'aids/ineligible' => 'api_aides#ineligible'
      get 'aids/uncertain'  => 'api_aides#uncertain'
      get 'ping' => 'api_aides#ping'
    end
  end

  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)

  root 'welcome#index'
  post 'accept_all_cookies' => 'welcome#accept_all_cookies'

  namespace :admin do
    resources :explicitations
    resources :conventions
    resources :api_users
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :tracings
    resources :traces do
      get :export, on: :collection
    end
    resources :filters
    resources :aids, only: [:index, :show, :new, :edit, :destroy] do
      get :export, on: :collection
    end
    namespace :aid_creation do
      get  "new_aid_stage_1"
      post "create_stage_1"
      get  "new_aid_stage_2"
      post "hide_alert_convention"
      post "create_stage_2"
      get  "new_aid_stage_3"
      post "create_stage_3"
      get "new_aid_stage_4"
      post "create_stage_4"
      get "new_aid_stage_5"
      post "create_stage_5"
    end
    controller 'pages' do
      get 'get_custom_filter_menu'
      get 'get_reinit'
      post 'post_reinit'
      get 'get_zrr'
      post 'post_zrr'
      get 'get_cache'  if ENV["R7_MODE"]
      post 'post_cache'  if ENV["R7_MODE"]
      get 'get_ref_data'
      post 'post_ref_data'
      get 'get_transfer_descr'
      post 'post_transfer_descr'
      get 'get_delete_trace'
      post 'post_delete_trace'
      get 'get_hidden_admin'
    end
    get 'status', to: 'status#index'
    resources :variables
    resources :contract_types
    root to: "aids#index"
  end

  # a route to check exception are propertly sent
  resources :divide_by_zero,         only: [:index]
  

  resources :r7_pen, only: [:index]  if ENV["R7_MODE"]
  controller 'r7_pen' do
    get 'get_r7_info' if ENV["R7_MODE"]
    post 'post_r7_data' if ENV["R7_MODE"]
    delete 'delete_r7_data' if ENV["R7_MODE"]
    delete 'delete_aid/:aid_slug', to: 'r7_pen#delete_aid' if ENV["R7_MODE"]
    post 'clear_cache', to: 'r7_pen#clear_cache' if ENV["R7_MODE"]
  end

  resources :age_questions,         only: [:new, :create]
  resources :address_questions,     only: [:new, :create]
  resources :allocation_questions,  only: [:new, :create]
  resources :category_questions,    only: [:new, :create]
  resources :grade_questions,       only: [:new, :create]
  resources :inscription_questions, only: [:new, :create]
  resources :are_questions,         only: [:new, :create]
  resources :other_questions,       only: [:new, :create]

  resources :contact,               only: [:index, :create]
  resources :contact_sent,          only: [:index]
  
  resources :cookies,               only: [:edit, :update]
  resources :confidentiality,       only: [:index]
  
  
  resources :aides, only: [:index] do
    collection do
      resources :type, only: [:show]
      resources :detail, only: [:show]
    end
  end
  post 'aides/search_for_aids'
  get 'get_search_front', to: 'aides#get_search_front'
  post 'post_search_front', to: 'aides#post_search_front'

  resources :req,       only: [:index]
  resources :reqip,    only: [:index]
  
  get 'conditions-generales-d-utilisation', to: 'welcome#terms'
  get 'welcome/index'
  post 'welcome/start_wizard'

  get 'accessibilite', to: 'welcome#accessibility'

  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'sitemap.xml', :to => 'sitemap#index', :as => 'main_sitemap'
  get 'aides-sitemap.xml', :to => 'sitemap#aides', :as => 'aides_sitemap'
  get 'types-aides-sitemap.xml', :to => 'sitemap#types', :as => 'types_sitemap'

  get '/stats', to: redirect('https://datastudio.google.com/reporting/1CHDn1yxUb7yK_rgH39nHB1-b90Sg22-q/page/IDGN')

end
