class AffiliateDashboardsController < ApplicationController
  # before_action :set_affiliate_dashboard, only: [:show, :edit, :update, :destroy]
  layout "affiliate_dashboard"

  def clients
    @clients = User.all.where(affiliate_id: current_affiliate)
    # @orders = Order.all.find(params[:seller_id])

    @orders_e = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] ).paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_f = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] ).paginate(:page => params[:day_orders_page_1], :per_page => 7)
    @orders_g = Order.all.where(seller: current_affiliate.users ).where(order_status: [2] ).paginate(:page => params[:week_orders_page_1], :per_page => 14)

    @orders_month = @orders_e.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_f.all.group_by { |day|  day.created_at.beginning_of_day }
    @orders_week = @orders_g.all.group_by { |week|  week.created_at.beginning_of_week }

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

  # GET /affiliate_dashboards
  # GET /affiliate_dashboards.json
  def index
    @affiliate_dashboards = AffiliateDashboard.all
  end

  # GET /affiliate_dashboards/1
  # GET /affiliate_dashboards/1.json
  def show
  end

  # GET /affiliate_dashboards/new
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
      params.require(:affiliate_dashboard).permit(:clients, :analytics, :orders)
    end
end
