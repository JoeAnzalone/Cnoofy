Cnoofy::Application.routes.draw do

  devise_for :users

  get  '/new/:type', :to => 'posts#new', :as => :new_post
  
  resources :posts do
    resources :comments
  end

  resources :blogs do
    resources :posts
    match 'settings' => 'blogs#edit'
    match 'followers'
  end

  put    'like/:post_id' => 'likes#create',  :as => :like
  delete 'unlike/:post_id' => 'likes#destroy', :as => :unlike
  resources :likes, :controller => 'likes', :as => :likes

  put    'follow/:blog_id' => 'subscriptions#create',  :as => :follow
  delete 'unfollow/:blog_id' => 'subscriptions#destroy', :as => :unfollow
  resources :following, :controller => 'subscriptions', :as => :subscriptions

  get 'tagged/:tag', to: 'posts#index', as: :tag

  match '' => 'blogs#show_posts', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  authenticated :user do
    root :to => "posts#following"
  end

  devise_scope :user do
    get '/', :to => 'devise/registrations#new'
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"
end