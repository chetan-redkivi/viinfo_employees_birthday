ViinfoEmployeesBirthday::Application.routes.draw do


  resources :custom_messages

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users  do
    match '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :vi_employee_authentications, :controllers => { :omniauth_callbacks => "vi_employee_authentications/omniauth_callbacks" } do
    match '/vi_employee_authentications/sign_out' => 'devise/sessions#destroy'
    match '/vi_employee_authentications/sign_in' => 'vi_employee_authentications/sessions#create'
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
   match '/send_email' => 'home#send_email'
   match '/facebook_connect' => 'home#facebook_connect'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
