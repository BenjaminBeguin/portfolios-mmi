Rails.application.routes.draw do
  get 'skills/index'

  get 'skills/new'

  get 'jobs/index'

  get 'jobs/new'
  post 'jobs/create'


  get 'portfolios/new'
  get 'portfolios/index'
  post 'portfolios/create'

  get 'users/show'

  get 'users/index'


  Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
