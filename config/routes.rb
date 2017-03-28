Rails.application.routes.draw do


  get 'villes/index'
  get 'villes/new'
  post 'villes/create'
  get 'villes/edit/:id' => "villes#edit", :as => :villes_edit
  patch 'villes/update'


  root "portfolios#index"

  get 'skills/index'
  get 'skills/new'

  get 'jobs/index'
  get 'jobs/new'
  get 'jobs/edit/:id' => "jobs#edit", :as => :jobs_edit
  post 'jobs/create'
  patch 'jobs/update'

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


  Rails.application.routes.draw do
  get 'villes/index'

  get 'villes/new'

      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # ------------ admin -------- #

  get '/admin/home' => 'users#admin_home', :as => :admin_home
  get '/admin/portfolios' => 'users#admin_portfolios', :as => :admin_portfolios
  get '/admin/portfolio/:id' => 'users#admin_edit_portfolio', :as => :admin_edit_portfolio
  get '/admin/portfolio/action/publish' => 'portfolios#admin_toggle_publish' , :as => :admin_toggle_publish
  get '/admin/portfolio/action/sotd' => 'portfolios#admin_toggle_sotd' , :as => :admin_toggle_sotd





end
