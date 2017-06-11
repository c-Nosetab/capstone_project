Rails.application.routes.draw do

  get '/employees' => 'employees#index'
  get '/employees/new' => 'employees#new'
  post '/employees' => 'employees#create'
  get '/employees/:id' => 'employees#show'
  get '/employees/:id/edit' => 'employees#edit'
  patch '/employees/:id' => 'employees#update'
  delete 'employees/:id' => 'employees#destroy'

  get '/shifts' => 'shifts#index'
  get '/shifts/new' => 'shifts#new'
  post '/shifts' => 'shifts#create'
  get '/shifts/:id' => 'shfits#show'
  get '/shifts/:id' => 'shifts#edit'
  get '/shifts/:id/edit' => 'shifts#update'
  delete '/shifts/:id' => 'shifts#destroy'


  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
