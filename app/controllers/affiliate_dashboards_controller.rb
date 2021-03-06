class AffiliateDashboardsController < ApplicationController
  # before_action :set_affiliate_dashboard, only: [:show, :edit, :update, :destroy]
  layout "affiliate_dashboard"

  def clients
    @clients = User.all.where(affiliate_id: current_affiliate)

    @client_orders = @clients
    # @orders = Order.all.find(params[:seller_id])
    # @clients_orders =.@clients.orders.where(order_status: [2] ).group_by_day(:created_at, last: 7).count

    # @orders_clients = @clients.where(sales: )

    @orders_e = Order.all.where(seller: @clients ).where(order_status: [2] ).paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_h = Order.all.where(seller: @clients ).where(order_status: [2] ).order('created_at DESC')

    @orders_week_00 = @orders_h.group_by_day(:created_at, last: 1, series: false).count

    @orders_f = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] ).paginate(:page => params[:day_orders_page_1], :per_page => 7)
    @orders_i = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] )

    @orders_g = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] ).paginate(:page => params[:week_orders_page_1], :per_page => 14)
    @orders_j = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] )


    @orders_month = @orders_h.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_h.all.group_by { |day|  day.created_at.beginning_of_day }
    @orders_week = @orders_j.all.group_by { |week|  week.created_at.beginning_of_week }

    @orders_week_1 = @orders_j.all.group_by { |week|  week.created_at.beginning_of_week }.count


    # @orders_month_pag = @orders_month.order('created_at DESC').paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_day_pag = @orders_i.all.group_by { |day|  day.created_at.beginning_of_day }
    @orders_week_pag = @orders_j.all.group_by { |week|  week.created_at.beginning_of_week }


    @orders_day_2 = @orders_h.all.group_by_day(:created_at, last: 1, series: false)
    @orders_week_2 = @orders_h.all.group_by_day(:created_at, last: 7)
    @orders_month_2 = @orders_h.all.group_by_month(:created_at, series: false)
    @orders_month_3 = @orders_h.all.group_by_day(:created_at, last: 30, series: false)

    @orders_week_count = @orders_week_2.count



  end

  def client_page
    @client = User.find(params[:id])




  end

  def flash_class_name(name)
    case name
    when 'notice' then 'success'
    when 'alert'  then 'danger'
    else name
    end
end

  def settings
    @user = current_affiliate
    @stripe_account = current_affiliate.stripe_account
  end

  def account_affiliate

    @balance = Stripe::Balance.retrieve(
      { stripe_account: current_affiliate.stripe_account.acct_id }
    )


    @transaction = Stripe::BalanceTransaction.all(
      {
        :limit => 10,
        type: 'payment',
        available_on: { gt: Time.now.to_i },
      },
        { stripe_account: (current_affiliate).stripe_account.acct_id }
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


  def analytics

  end


  def orders

  end

  def new
    @affiliate_dashboard = AffiliateDashboard.new
  end

  # GET /affiliate_dashboards/1/edit
  def edit
  end

  # POST /affiliate_dashboards
  # POST /affiliate_dashboards.json
  def create
    @affiliate_dashboard = AffiliateDashboard.new(affiliate_dashboard_params)

    respond_to do |format|
      if @affiliate_dashboard.save
        format.html { redirect_to @affiliate_dashboard, notice: 'Affiliate dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @affiliate_dashboard }
      else
        format.html { render :new }
        format.json { render json: @affiliate_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /affiliate_dashboards/1
  # PATCH/PUT /affiliate_dashboards/1.json
  def update
    respond_to do |format|
      if @affiliate_dashboard.update(affiliate_dashboard_params)
        format.html { redirect_to @affiliate_dashboard, notice: 'Affiliate dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @affiliate_dashboard }
      else
        format.html { render :edit }
        format.json { render json: @affiliate_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affiliate_dashboards/1
  # DELETE /affiliate_dashboards/1.json
  def destroy
    @affiliate_dashboard.destroy
    respond_to do |format|
      format.html { redirect_to affiliate_dashboards_url, notice: 'Affiliate dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliate_dashboard
      @affiliate_dashboard = AffiliateDashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def affiliate_dashboard_params
      params.require(:affiliate_dashboard).permit(:clients, :analytics, :orders, :approved)
    end
end
