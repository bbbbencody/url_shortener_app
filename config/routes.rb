Rails.application.routes.draw do
	root 'links#new'

	get ':slug', to: 'links#link_through', as: 'link'
	get ':slug/edit', to: 'links#edit', as: 'edit_link'
	delete ':slug', to: 'links#expire'

	resources :links, only: [:new,  :create]
end
