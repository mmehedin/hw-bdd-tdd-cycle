Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'show' => 'movies#show'
  get 'movies/:id/same_director' => 'movies#same_director', :as => :same_director
  #post 'movies/:id/edit' => 'movies#add_director'
end
