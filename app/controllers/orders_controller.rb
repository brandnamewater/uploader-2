class OrdersController < ApplicationController
  layout :admin_layout
  load_and_authorize_resource
  # load_and_authorize_resource :order, through: :user

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # before_action :cancel_update, only: [:edit, :update, :destroy]
  # before_action :charge_update, only: [:edit, :update, :destroy]

  before_action :authenticate_user!, only: [:update, :destroy, :edit]
  # before_action :deny_to_visitors



  def buyer_purchases
    @orders = Order.all.where(buyer: current_user || current_buyer)
  end


  def order_and_sales_upload
    if Order.where(id: Sales_upload.pluck(:order_id)) == true
    end
  end


  def sales
    @orders = Order.all.where(seller: current_user) || @orders = Order.all.where(seller: current_buyer)
    @order = Order.new
  end

  def purchases
    @user = current_user
    orders = Order.where(buyer: current_user)
    orders_charged = orders.where(order_status: [2] )
    orders_created = orders.where(order_status: [1] )
    @orders_pending = orders_created.order('created_at DESC').paginate(:page => params[:orders_pending_page_1], :per_page => 8)
    @orders_charged = orders_charged.order('created_at DESC').paginate(:page => params[:orders_charged_page_1], :per_page => 8)
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @user = current_user
    @video_order = VideoOrder.new
    @video_order_id = @video_order.order_id
    # @order = current_user.order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
    #@order = Order.find(params[:order_id])
    respond_to do |format|

      format.html

      format.js

    end
  end

  # GET /orders/1/edit
  def edit
    @user = current_user.buyer
  end


  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
      #@order.buyer_id = current_buyer.id
      #@order.buyer_id = (current_buyer.id || current_user.id)
    @order.seller_id = @seller.id
    @order.order_price = @listing.price

        # @listing = .find(params[:listing_id])

        if @order.valid?
          begin
            @amount = (@listing.price).to_i * 100
            token = params[:stripeToken]
            payment_form = params[:payment_form]

            customer = Stripe::Customer.create({
              :source  => 'tok_visa',
              # :source => (@order.buyer_id)
              :email => params[:stripeEmail],
            })

            charge = Stripe::Charge.create({
              amount: @amount,
              currency: 'usd',
              customer: customer.id,
              capture: false,
          })

          @order.stripe_customer_token = customer.id

          rescue Stripe::CardError => e
            charge_error = e.message
          end
          if charge_error
            flash[:error] = charge_error
            redirect_to listing_path(@listing)
          else

    # if @order.valid?
    #   begin
    #     @amount = (@listing.price).to_i * 100
    #     token = params[:stripeToken]
    #     payment_form = params[:payment_form]
    #
    #     customer = Stripe::Customer.create(
    #       :email => params[:stripeEmail],
    #     )
    #
    #     charge = Stripe::Charge.create({
    #       :source  => 'tok_visa',
    #       :amount      => @amount,
    #       :description => 'Rails Stripe customer',
    #       :currency    => 'usd'
    #     })
    #
    #   rescue Stripe::CardError => e
    #     charge_error = e.message
    #   end
    #   if charge_error
    #     flash[:error] = charge_error
    #     redirect_to new_charge_path
    #     @order.destroy
    #   else
        respond_to do |format|
          if @order.save
            @order.update_column(:order_status, 1)
            if user_signed_in?
              @user = current_user
              OrderMailer.order_email(@user, @order).deliver
              format.html { redirect_to ([@user, @order]), notice: 'Order was successfully created.' }
              format.json { render :show, status: :created, location: @order }
              else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
              end
              if buyer_signed_in?
                @user = current_buyer
                OrderMailer.order_email(@user, @order).deliver
                format.html { redirect_to ([@user, @order]), notice: 'Order was successfully created.' }
                format.json { render :show, status: :created, location: @order }
              else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
              end
            end
          end
        end
      end
    end


  def update
    respond_to do |format|
      if @order.update(order_status)
        if params[:order_status == "cancelled"]
          format.html { redirect_to ([@user, @order]), notice: 'Order was successfully cancelled.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
      if @order.update(order_params)
        if user_signed_in?
          format.html { redirect_to ([@user, @order]), notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
        if buyer_signed_in?
          format.html { redirect_to ([@user, @order]), notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end





  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :email, :image, :description)
    end

    def order_status
      params.require(:order).permit(:order_status)
    end

    def order_charge
      params.require(:order).permit(:video, :order_status)
    end


    def deny_to_visitors
      redirect_to root_path unless user_signed_in? or buyer_signed_in?
    end

    def user_orders
      @order.buyer_id = current_buyer.id or current_user
    end

    def check_video
      false if video_changed? && !video_was.nil? # or empty or whatever
      true
    end

    def admin_layout
    case 'purchases'
    when 'purchases'
      'admin'
    when 'sales'
    else
      'application'
    end
  end

end
