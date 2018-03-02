Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pixel do
    get :inc
    get :create_new_pixel
  end
end
