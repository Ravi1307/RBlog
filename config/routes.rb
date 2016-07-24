Rails.application.routes.draw do
  
  get '/login', :to => 'account#login';
  get '/register', :to => 'account#new';
  get '/:user/profile', :to => 'account#edit';
  get '/:user/logout', :to => 'account#logout';
  get '/:user/delete_account', :to => 'account#destroy';
  get '/:user/change_password', :to => 'account#change_password';
  
  post '/register', :to => 'account#create';
  post '/login', :to => 'account#attempt_login';
  post '/:user/profile', :to => 'account#update';
  post '/:user/change_password', :to => 'account#update_password';
    
  get '/posts', :to => 'posts#home';
  get '/about', :to => 'posts#about';
  get '/contact', :to => 'posts#contact';
  get '/posts/show', :to => 'posts#show';
  get '/site_map', :to => 'posts#site_map';
  get '/:user/posts/new', :to => 'posts#new';
  get '/:user/posts', :to => 'posts#my_posts';
  get '/:user/posts/edit', :to => 'posts#edit';
  get '/:user/posts/delete', :to => 'posts#destroy';

  post '/:user/posts/new', :to => 'posts#create';
  post '/:user/posts/edit', :to => 'posts#update';
  post '/contact', :to => 'posts#send_contact_form';
  
  post '/:user/posts/comments/new', :to => 'comments#create';
  
  root 'posts#home';
  
#  resources :posts do
#    resources :comments;
#  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
