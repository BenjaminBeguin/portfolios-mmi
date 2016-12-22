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
  get '/:category' => "portfolios#category",  :as => :show_category
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




end
