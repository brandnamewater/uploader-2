Rails.application.routes.draw do

  resources :affiliate_dashboards
  devise_for :affiliates
  resources :affiliates
  resources :video_orders


  authenticated :affiliate do
    get 'a/clients' => 'affiliate_dashboards#clients'

  end

get 'client/:id', to: "affiliate_dashboard#client_page"

  authenticated :user, ->(user) { user.buyer? } do
    get 'c/shouts' => 'customer_dashboard#purchases'
    get 'c/dashboard' => 'customer_dashboard#buyer_dashboard'
  end


  resources :admin_dashboard
  # resources :stripe_accounts
  # resources :user_listings
  mount StripeEvent::Engine, at: '/stripe-events' # provide a custom path


  authenticated :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"

    get 'admin/admins' => 'admin_dashboard#admins'
    get 'admin/users' => 'admin_dashboard#users'
    get 'admin/sellers' => 'admin_dashboard#sellers'
    get 'admin/buyers' => 'admin_dashboard#buyers'
    get 'admin/affiliates' => 'admin_dashboard#affiliates'
    get 'admin/orders' => 'admin_dashboard#orders'
    get 'admin/listings' => 'admin_dashboard#listings'
    get 'admin/analytics' => 'admin_dashboard#website_analytics'


    get 'admin/create_seller' => 'users#new'
    post 'admin/create_seller' => 'users#add_user'

  end

  devise_for :buyers
  resources :orders
  devise_for :users, controllers: { confirmations: 'confirmations' }

  resources :users

  resources :stripe_accounts

  resources :bank_accounts

  resources :orders do
    resources :video_orders
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :orders
  end

    resources :orders

resources :bank_accounts


  get 'stripe_show' => "stripe_accounts#show"


  get 'stripe_' => "stripe_account#create"

  get 'stripe_new' => "stripe_account#new"

  get 'cancel' => "orders#cancel_update"


  get 'seller' => "listings#seller"

  get 'edit_stripe' => "stripe_accounts#edit"




  #new_order_sales_upload post '/orders/:order_ids(.:format) sales_uploads#new'
 get 'sales' => "orders#sales"
 post 'sales' => "orders#sales"

  get 'talent' => "listings#listings_page"

  get 'purchases' => "orders#purchases"

  get 'buyer_purchases' => "orders#buyer_purchases"



  get 'dashboard' => "dashboard#dashboard"
  get 'shouts' => "dashboard#tables"
  get 'charts' => "dashboard#charts"
  get 'settings' => "dashboard#settings"
  get 'account' => "dashboard#account"
  get 'payout_destination' => "dashboard#payout_destination"

  get 'account_affiliate' => "affiliate_dashboards#account_affiliate"


get 'auth' => "users#index"

get 'stripe' => "listings#stripe"

get 'analytics' => "dashboard#order_analytics"





  get 'car' => "listings#carousel"

  root to: "listings#index"



end
