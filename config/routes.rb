Rails.application.routes.draw do
  get 'skills/index'

  get 'skills/new'

  get 'jobs/index'

  get 'jobs/new'

  get 'portfolios/index'

  get 'users/show'

  get 'users/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
