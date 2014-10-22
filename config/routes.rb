Labs::Application.routes.draw do
  devise_for :users

  resources :projects, defaults: { format: 'json' } do
    match :public, via: :get, on: :collection
  end

  get '/tags' => 'tags#index'

end
