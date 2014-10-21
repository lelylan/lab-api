Labs::Application.routes.draw do
  devise_for :users

  resources :projects, defaults: { format: 'json' }
end
