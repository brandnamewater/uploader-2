class AdminDashboardController < ApplicationController
  layout "admin_dashboard"

  def users
    @users = User.all
    @users_count_buyers = User.all.where(role: [1]).count
    @users_count_sellers = User.all.where(role: [2]).count

  end

  def sellers
    @users = User.all.where(role: [2])
  end

  def buyers
    @users = User.all.where(role: [1])

  end

  def admins
    @users = User.all.where(admin: [1])

  end

  def affiliates
    @affiliates = Affiliate.all
    @users = User.all

  end

  def affiliate
    @affiliates = Affiliate.all
    @users = User.all

  end

  def orders
    @orders = Order.all.order('created_at DESC').paginate(:page => params[:admin_orders_page], :per_page => 30)
    @orders_count_all = Order.all.count
    @orders_count_charged = Order.all.where(order_status: [2] ).count
    @orders_count_created = Order.all.where(order_status: [1] ).count

  end

  def listings
    @listings = Listing.all.paginate(:page => params[:admin_listings_page], :per_page => 30)
    @listings_count_all = Listing.all.count
  end

  def website_analytics
    @orders_referring = Order.joins(:visit).group("referring_domain").count
    @orders_country = Order.joins(:visit).group("city").count
    @visits_all = Ahoy::Visit.all
    @visits_referring = Ahoy::Visit.group("referring_domain").count

  end

  def create_seller
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
    if @user.update(user_params) # <- you'll need to define these somewhere as well
        format.html { redirect_to '/admin_dashboard/User', notice: "yaho5o" }
        format.json { render json: @user }
    else
        format.html { render :edit }
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
    end

    @affiliate = Affiliate.find(params[:id])

    if @affiliate.update(affiliate_dashboard_params) # <- you'll need to define these somewhere as well
        format.html { redirect_to '/admin_dashboard/Affiliate', notice: "yaho5o" }
        format.json { render json: @affiliate }
    else
        format.html { render :edit }
        format.json { render json: { errors: @affiliate.errors }, status: :unprocessable_entity }
    end

  end

end


  private


    def user_params
      params.require(:user).permit(:name, :approved, :seller, :buyer, :admin, stripe_account: [:stripe_account])
    end

    def affiliate_dashboard_params
      params.require(:affiliate_dashboard).permit(:clients, :analytics, :orders, :approved)
    end


end
