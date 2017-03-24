Myblog::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",:registrations => "registrations"}
  #get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
    resources :posts  do
      get 'save_comment'
      get 'all_post'
      get 'show_post_and_comment'
      get 'refresh_comments'
      post 'like_unlike_post_and_comment'
      get "serve", :on => :member
      get "list_grid_view"
      get "search_post"
      collection do
        post 'mark_read_to_notification'
      end
    end
    resources :users  do
      post 'set_background'
    end
    match 'posts/:comment_id/edit_and_delete_comment' => 'posts#edit_and_delete_comment'
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
  post '/tinymce_assets' => 'tinymce_assets#create'
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
   root :to => 'posts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
