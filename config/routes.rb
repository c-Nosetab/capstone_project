Rails.application.routes.draw do

  get '/signup' => 'companies#new'
  post '/companies' => 'companies#create'
  get '/company' => 'companies#show'
  get '/company/edit' => 'companies#edit'
  patch '/company' => 'companies#update'
  delete '/company' => 'companies#destroy'

  get '/positions' => 'positions#index'
  get '/positions/new' => 'positions#new'
  post '/positions' => 'positions#create'
  get '/positions/:id' => 'positions#show'
  get '/positions/:id/edit' => 'positions#edit'
  patch '/positions/:id' => 'positions#update'
  delete '/positions/:id' => 'positions#destroy'

  get '/employees' => 'employees#index'
  get '/employees/new' => 'employees#new'
  post '/employees' => 'employees#create'
  get '/employees/:id' => 'employees#show'
  get '/employees/:id/edit' => 'employees#edit'
  patch '/employees/:id' => 'employees#update'
  delete 'employees/:id' => 'employees#destroy'

  get '/availability' => 'availabilities#index'
  get '/availability/new' => 'availabilities#new'
  post '/availability' => 'availabilities#create'
  get '/availability/:id' => 'availabilities#show'
  get '/availability/:id/edit' => 'availabilities#edit'
  patch '/availability/:id' => 'availabilities#update'
  delete 'availability/:id' => 'availabilities#destroy'

  get '/shifts' => 'shifts#index'
  get '/shifts/new' => 'shifts#new'
  post '/shifts' => 'shifts#create'
  get '/shifts/:id' => 'shifts#show'
  get '/shifts/:id/edit' => 'shifts#edit'
  patch '/shifts/:id' => 'shifts#update'
  delete '/shifts/:id' => 'shifts#destroy'

  get '/employee_signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
