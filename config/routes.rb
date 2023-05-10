Rails.application.routes.draw do
  devise_for :users

  resources :albums

  delete 'albums/:id/delete_cover', to: 'albums#delete_cover'
  delete 'albums/:id/images/:image_id', to: 'albums#del_img', as: 'del_album_img'
  get '/myalbums', to: 'albums#myalbums', as: 'myalbums'

  root 'albums#index'
  get 'tags/:tag', to: 'albums#index', as: 'tag'
end
#  def after_sign_in_path_for(resource)
#     myalbums_path
#  end
