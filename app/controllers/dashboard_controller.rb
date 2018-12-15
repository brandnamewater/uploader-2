class DashboardController < ApplicationController
  before_action :authenticate
  # load_and_authorize_resource
  layout :determine_layout


  def account

    @balance = Stripe::Balance.retrieve(
      { stripe_account: (current_user || current_affiliate).stripe_account.acct_id }
    )


    @transaction = Stripe::BalanceTransaction.all(
      {
        :limit => 10,
        type: 'payment',
        available_on: { gt: Time.now.to_i },
      },
        { stripe_account: (current_user || current_affiliate).stripe_account.acct_id }
    )

    @transaction_1 = Stripe::BalanceTransaction.all(
      {
        :limit => 1,
        type: 'payment',
        available_on: { gt: Time.now.to_i },
      },
        { stripe_account: (current_user || current_affiliate).stripe_account.acct_id }
    )

    @transfer = Stripe::Transfer.list(
      {
        limit: 100
      },
      {stripe_account: (current_user || current_affiliate).stripe_account.acct_id }
    )

    @payments = Stripe::Charge.list(
      {
        limit: 100, # The number of charges to retrieve (between 1 and 100)
        expand: ['data.source_transfer', 'data.application_fee'] # Expand other objects for additional detail
      },
      { stripe_account: (current_user || current_affiliate).stripe_account.acct_id } # The Stripe ID of the user viewing the dashboard
    )

    @payouts = Stripe::Payout.list(
      {
        limit: 100,
        expand: ['data.destination'] # Get some extra detail about the bank account
      },
      { stripe_account: (current_user || current_affiliate).stripe_account.acct_id } # Again, authenticating with the ID of the connected account
    )

    @payout_1 = Stripe::Payout.list(
      {
        limit: 1,
        expand: ['data.destination'] # Get some extra detail about the bank account
      },
      { stripe_account: (current_user || current_affiliate).stripe_account.acct_id } # Again, authenticating with the ID of the connected account
    )



  end

  def payout_destination

    @txns = Stripe::BalanceTransaction.list(
      {
        payout: params[:id], # The ID of the payout you want transactions for
        expand: ['data.source.source_transfer'], # Expand the source_transfer for extra detail
        limit: 100
      },
      { stripe_account: (current_user || current_affiliate).stripe_account.acct_id }
    )

  end


  def settings
    @user = (current_user || current_affiliate)
    @stripe_account = (current_user || current_affiliate).stripe_account
  end

  def order_analytics
    @orders_referring = Order.joins(:visit).group("referring_domain").count
    @orders_country = Order.joins(:visit).group("city").count
    # @listing_visits = Ahoy::Event.where(name: "Listing Viewed").where_properties(listing_id: current_user).count

  end

  def dashboard

    @orders_a = Order.all.where(seller: current_user).paginate(:page => params[:month_orders_page], :per_page => 12)
    @orders_b = Order.all.where(seller: current_user).paginate(:page => params[:day_orders_page], :per_page => 7)

    @orders_c = Order.all.where(seller: current_user).where("created_at < updated_at").paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_d = Order.all.where(seller: current_user).where("created_at < updated_at").paginate(:page => params[:day_orders_page_1], :per_page => 7)

    @orders_e = Order.all.where(seller: current_user).where(order_status: [2] ).paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_f = Order.all.where(seller: current_user).where(order_status: [2] ).paginate(:page => params[:day_orders_page_1], :per_page => 7)

    @orders_month = @orders_e.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_b.all.group_by { |day|  day.created_at.beginning_of_day }


    @order = Order.new

  end

  def tables

    user = current_user
    orders = Order.where(seller: user)
    orders_with_video = Order.find_by(video: present?)
    orders_charged = orders.where(order_status: [2] )
    orders_created = orders.where(order_status: [1] )


    @orders_tables = orders.order('created_at DESC').paginate(:page => params[:all_orders_page], :per_page => 15)
    @orders_tables_comp = orders_charged.order('created_at DESC').paginate(:page => params[:comp_orders_page], :per_page => 8)
    @orders_tables_up = orders_created.order('created_at DESC').paginate(:page => params[:up_orders_page], :per_page => 8)

  end

  def charts
    @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)
    @orders_month = @orders.group_by { |mon| mon.created_at.beginning_of_month }



  end


  private

  def authenticate
    if current_affiliate != nil
     authenticate_affiliate!
    else
     authenticate_user!
    end

  end

  def determine_layout
    current_affiliate ? "affiliate_dashboard" : "admin"
  end

end
