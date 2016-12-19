Rails.application.routes.draw do
  

  get 'villes/index'
  get 'villes/new'
  post 'villes/create'


  root "users#index"

  get 'skills/index'
  get 'skills/new'

  get 'jobs/index'
  get 'jobs/new'
  post 'jobs/create'

  get 'portfolios/new'
  get '/:category' => "users#category",  :as => :show_category
  get '/city/:ville' => "users#ville",  :as => :show_city
  get 'portfolios/index'
  post 'portfolios/create'

  get 'portfolio/:slug' => "users#show", :as => :show_portfolio
 
  get 'users/index'


  Rails.application.routes.draw do
  get 'villes/index'

  get 'villes/new'

      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
