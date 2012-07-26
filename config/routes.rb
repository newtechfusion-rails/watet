Watet::Application.routes.draw do
get "errors/error_404"
get "errors/error_500"
	match "/auth/:provider/callback" => "sessions#create"
	match "/signout" => "sessions#signout", :as => :signout
  #match "/users/:user/products/send" => "products#send", :via => :post
	resources :users, :only => [:show] do
		resources :products, :except => [:index, :new, :show] do
		  collection do
		    post "sendlist"
		  end
		end
	end

 
  match "edit/:id" => "products#edit"
  match "destroy/:id" => "products#destroy"
  match "/products/update" => "products#update"
  match "show/:id" => "users#show"
  match "profile/:id" => "users#profile"
  match "product_profile/:id" => "users#product_profile"
  match "product_friend_profile/:id" => "users#product_friend_profile"
  match "delete_image/:id" => "users#delete_image"
  match "delete_image1/:id" => "users#delete_image1"
  match "delete_image2/:id" => "users#delete_image2"
  match "delete_image3/:id" => "users#delete_image3"


  match "add_wish/:id" => "users#add_wish"
  post "/users/:id" =>"users#add_wish"
  match "/terms" =>"users#terms"
  match "/terms_and_conditions" =>"products#terms_and_conditions"
  match  "/users/show" => "users#show"
  match  "/products/ordering_list/:id" => "products#ordering_list"
  match "/contact_us" => "products#contact_us"
   match "/products/contact_us_user" => "products#contact_us_user"

  match '/:locale' => 'users#show'
  match '/:locale' => 'users#add_wish'
  match '/:locale' => "products#edit"
  match '/:locale' => 'home#index'
scope "(:locale)", :locale => /en|sd|pl|fn|rs/ do
 resources :users
end

	get "home/index"


  ############## For WebServises
  match "users_product_list/:id" => "webservices#users_product_list"
  match "users_friend_list/:id" => "webservices#users_friend_list"


  match "show_list/:id" => "webservices#show_list"
  match "profile_product/:id" => "webservices#profile_product"
  match "product_edit/:id" => "webservices#product_edit"
  match "product_delete/:id" => "webservices#product_delete"
  match "add_product/:id" => "webservices#add_product"
  match "friend_products_list/:id" => "webservices#friend_products_list"
  match "friend_product_profile/:id" => "webservices#friend_product_profile"
  match "product_update/:id" => "webservices#product_update"







  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
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
  # match ':controller(/:action(/:id(.:format)))'
  if Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'error#error_404'
  end
end
