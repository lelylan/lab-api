Lab::Application.routes.draw do
  devise_for :users

  resource :projects
end
