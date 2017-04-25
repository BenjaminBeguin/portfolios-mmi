Rails.application.routes.draw do

  root "portfolios#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  scope '/admin' do
    get '/' => 'users#admin_home', :as => :admin_home
    scope '/portfolios' do
      get '/' => 'users#admin_portfolios', :as => :admin_portfolios
      get '/action/publish' => 'portfolios#admin_toggle_publish' , :as => :admin_toggle_publish
      get '/action/sotd' => 'portfolios#admin_toggle_sotd' , :as => :admin_toggle_sotd
      scope '/edit/:id' do
        get '/' => 'users#admin_edit_portfolio', :as => :admin_edit_portfolio
      end
    end
    scope '/ville' do
      get '/' => 'villes#index', :as => :villes_index
      get '/new' => 'villes#new', :as => :villes_new
      post '/create' => 'villes#create'
      patch '/update' => 'villes#update'
      scope '/edit/:id' do
        get '/' => 'villes#edit', :as => :villes_edit
      end
    end
    scope '/jobs' do
      get '/' => 'jobs#index', :as => :jobs_index
      get '/new' => 'jobs#new' , :as => :jobs_new
      post '/create' => 'jobs#create'
      patch '/update' => 'jobs#update'
      scope '/edit/:id' do
        get '/' => 'jobs#edit', :as => :jobs_edit
      end
    end
  end


  #api
  namespace :api do
  	namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
			resources :sessions, only: [:create]
			mount_devise_token_auth_for 'User', at: 'auth'

      get '/' => 'portfolios#index'
      get '/category/:category' => "portfolios#category",  :as => :api_show_category
      get '/city/:ville' =>"portfolios#ville",  :as => :api_show_city
      scope '/search' do
        get '/name/:q' => "portfolios#search_name",  :as => :api_search_name
        get '/:ville/:job' => "portfolios#search_perso",  :as => :api_search_perso
      end
      scope '/users' do
        get '/' => "users#index",  :as => :api_users_index
      end
      scope '/portfolio' do
				get '/' => 'portfolios#index'
				post '/' => 'portfolios#create'
				scope '/:id' do
					get '/' => 'portfolios#show'
					post '/' => 'portfolios#vote'
					put '/' => 'portfolios#update'
					# delete '/' => 'portfolio#delete'
				end
			end
    end
  end
  #
  # scope '/api/v1' do
  #   get '/' => "portfolios#index", :as => :api_index
  #   scope '/portfolios' do
  #
  #   end
  # end


  get 'portfolios/new'
  get '/sotd' => "portfolios#sotd",  :as => :sotd
  get '/:category' => "portfolios#category",  :as => :show_category
  get '/search/name/:q' => "portfolios#search_name",  :as => :search_name
  get '/search/:ville/:job' => "portfolios#search_perso",  :as => :search_perso
  get '/city/:ville' => "portfolios#ville",  :as => :show_city
  get 'portfolios/index'
  post 'portfolios/create'

  post 'portfolios/vote/:id' => "portfolios#vote", :as => :porfolios_add_vote

  get 'portfolio/:slug' => "users#show", :as => :show_portfolio

  get 'users/index'
  get 'users/edit/portfolio' => "portfolios#edit", :as => :edit_portfolio
  patch 'users/edit/portfolio/update' => "portfolios#update"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html






end
