class ListingsController < ApplicationController
  load_and_authorize_resource
  # layout :admin_layout
  layout :determine_layout, :only => [ :payment, :seller, :edit, :new ]
  # layout "admin", :only => [ :payment, :seller, :edit ]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # before_action :check_user, only: [:edit, :update, :destroy]
  # before_action :check_user_seller, only: [:create, :destroy]

  # before_action :user_approved, only: [:create]
  # attr_accessor :new_category_name

  def payment

    # Amount in cents
    @amount = (@listing.price)
    token = params[:stripeToken]
    payment_form = params[:payment_form]

    # customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #
    # )

    charge = Stripe::Charge.create({
      :source  => params[:stripeToken],
      # :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

  def seller
    @listings = Listing.where(user: current_user) #, created_at: :desc)
  end

  def listings_page
    @listings = Listing.all.where(listing_status: [1] )

    if params[:search]
      @listings = Listing.search(params[:search]).order(created_at: :desc)
    else
      @listings = Listing.all.order(created_at: :desc)
    end

    @categories = Category.all
    # if params[:category_id]
    #   @listings = Listing.where(:category_id => params[:category_id])
    # else
    #   @listings = Listing.all
    # end

  end

  def carousel
    @listings = Listing.all
    if params[:search]
      @listings = Listing.search(params[:search]).order(created_at: :desc)
    else
      @listings = Listing.all.order(created_at: :desc)
    end
    @listings_category = Listing.find(params[:category])
  end

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.where(listing_status: [1] )

    if params[:search]
      @listings = Listing.search(params[:search]).order(created_at: :desc)
    elsif params[:category]
      @listings = Category.find(params[:category]).listings
    else
      @listings = Listing.all.where(listing_status: [1] ).order(created_at: :desc)
    end
    @categories = Category.all


  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)


    @orders_a = Order.all.where(seller: current_user)
    @orders_month = @orders_a.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_a.all.group_by { |day|  day.created_at.beginning_of_day }
    @orders_date = @orders_a.all.group_by { |day|  day.created_at.beginning_of_day }

    @order = @listing.orders.new()



  end

  # GET /listings/new
  def new
    @listing = Listing.new
    # @categories = Category.all

    # 3.times do
    #   @listing.categories.build
    # end


    # @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:attr1, :name, :description, :price, :image, {category_ids: []}, :listing_status)
    end

    def check_user
      if current_user != @listing.user
        redirect_to root_url, alert: "Sorry, this isn't your listing"
      end
    end

    def check_user_seller
      if current_user != (current_user.seller == true )
        redirect_to root_url, alert: "Sorry, this isn't your listing 2"
      end
    end

    def user_approved
      if current_user != (@user.approved == true)
        redirect_to root_url, alert: "Sorry, your account isn't approved, please contact the admins"
      end
    end

    def determine_layout
      current_affiliate ? "affiliate_dashboard" : "admin"
    end

    # def admin_layout
    #   case 'payment'
    #   when 'payment'
    #     'application'
    #   when 'seller'
    #   else
    #     'application'
    #   end
    # end

end
