Rails.application.routes.draw do
	
  resources :memberships
  resources :groups
	devise_for :users, :controllers => { registrations: 'registrations' }

	resources :books

	root 'books#dashboard'

	get '/search' => 'books#search'
	get '/settings' => 'books#settings'


	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
