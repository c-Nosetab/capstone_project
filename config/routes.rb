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

  get '/' => 'employees#index'
  get '/employees' => 'employees#index'
  get '/employees/new' => 'employees#new'
  post '/employees' => 'employees#create'
  get '/employees/:id' => 'employees#show'
  get '/employees/:id/edit' => 'employees#edit'
  patch '/employees/:id' => 'employees#update'
  delete 'employees/:id' => 'employees#destroy'

  get '/employees/:user_id/availability/' => 'availability#index'
  get '/availability/new' => 'availability#new'
  post '/availability' => 'availability#create'
  get '/employees/:user_id/availability/:id' => 'availability#show'
  get '/employees/:user_id/availability/:id/edit' => 'availability#edit'
  patch '/employees/:user_id/availability/:id' => 'availability#update'
  delete '/employees/:user_id/availability/:id' => 'availability#destroy'

  get '/shifts' => 'shifts#index'
  get '/shifts/new' => 'shifts#new'
  post '/shifts' => 'shifts#create'
  get '/shifts/:id' => 'shifts#show'
  get '/shifts/:id/edit' => 'shifts#edit'
  patch '/shifts/:id' => 'shifts#update'
  delete '/shifts/:id' => 'shifts#destroy'

  post '/employee_shifts' => 'employee_shifts#create'
  delete '/employee_shifts/:id' => 'employee_shifts#destroy'

  post '/position_shifts' => 'position_shifts#create'
  delete '/position_shifts/:id' => 'position_shifts#destroy'

  get '/employee_signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/company/:company_id/data' => 'data_visuals#index'


  patch '/employees/:id/image', to: 'images#update', as: :update_image
  delete 'employees/:id/image' => 'images#destroy'


  namespace :api do
    namespace :v1 do
      get '/employees' => 'employees#index'
      post '/employees' => 'employees#create'
      get '/employees/:id' => 'employees#show'


      get '/positions' => 'positions#index'
      get '/positions/:id' => 'positions#show'

      get '/shifts' => 'shifts#index'
      get '/shifts/:id' => 'shifts#show'

      get '/employee_shifts' => 'employee_shifts#index'
      post '/employee_shifts' => 'employee_shifts#create'
      get '/employee_shifts/:id' => 'employee_shifts#show'
      delete '/employee_shifts' => 'employee_shifts#destroy'

      get '/position_shifts' => 'position_shift#index'
      post '/position_shifts' => 'position_shift#create'
      get '/position_shifts/:id' => 'position_shift#show'
      delete '/position_shifts' => 'position_shift#destroy'


      get '/data/:company_id' => 'data_visuals#show'


    end
  end



end
