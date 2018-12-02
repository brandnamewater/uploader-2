Rails.application.routes.draw do

  # devise_for :users
  resources :video_orders







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

  resources :users do
    resources :stripe_accounts
  end

  resources :stripe_accounts do
    resources :bank_accounts
  end

  resources :orders do
    resources :video_orders
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :orders
end

  resources :users do
    resources :orders
  end

resources :bank_accounts

  resources :orders do
    member do
      patch :charge_update
      put :charge_update
    end
  end


  get 'stripe_show' => "stripe_accounts#show"


  get 'stripe_' => "stripe_account#create"

  get 'stripe_new' => "stripe_account#new"

  get 'cancel' => "orders#cancel_update"

  # resources :listings do
  #   resources :charges
  # end
  # resources :orders do
  #   resource :charge, only: [:new, :create, :show]
  # end

  get 'seller' => "listings#seller"
  #
  # resource :orders
  # resolve('Charge') { [:charges] }

  # resource :charges
  # resolve('Charge') { [:orders] }

  # resources :charges
  get 'edit_stripe' => "stripe_accounts#edit"

  # get 'stripe_accounts/full' => "stripe_accounts#full"


  # resources :orders do
  #   resources :charges
  # end


  #new_order_sales_upload post '/orders/:order_ids(.:format) sales_uploads#new'
 get 'sales' => "orders#sales"
 post 'sales' => "orders#sales"

  #post 'sales' => "orders#sales"
  get 'talent' => "listings#listings_page"

  get 'purchases' => "orders#purchases"

  get 'buyer_purchases' => "orders#buyer_purchases"



  get 'dashboard' => "dashboard#dashboard"
  get 'shouts' => "dashboard#tables"
  get 'charts' => "dashboard#charts"
  get 'settings' => "dashboard#settings"
  get 'account' => "dashboard#account"
  get 'payout_destination' => "dashboard#payout_destination"


get 'auth' => "users#index"

get 'stripe' => "listings#stripe"

get 'analytics' => "dashboard#order_analytics"

# post 'charge' => "layouts#charges"
#
# post 'charge' => "listings#show"



  get 'car' => "listings#carousel"

  root to: "listings#index"


# get '/:user_link', to: 'user_listings#show'

end
