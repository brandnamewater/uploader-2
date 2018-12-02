class VideoOrdersController < ApplicationController
  before_action :set_video_order, only: [:show, :edit, :update, :destroy]

  # GET /video_orders
  # GET /video_orders.json
  def index
    @video_orders = VideoOrder.all
  end

  # GET /video_orders/1
  # GET /video_orders/1.json
  def show
  end

  # GET /video_orders/new
  def new
    @video_order = VideoOrder.new
  end

  # GET /video_orders/1/edit
  def edit
    @order = @video_order.order_id

  end

  # POST /video_orders
  # POST /video_orders.json
  def create

    @video_order = VideoOrder.new(video_order_params)
    @order = Order.find(params[:order_id])

    @video_order.order_id = @order.id

    respond_to do |format|
      if @order.video_order.present?
          format.html { redirect_to @order, notice: 'Already complete dog!.' }
          format.json { render :show, status: :created, location: @video_order }
        else

      if @video_order.valid?
        begin
          charge = Stripe::Charge.create({
            :amount      => (@order.order_price).to_i * 100,
            :description => 'Rails Stripe customer',
            :currency    => 'usd',
            :customer => @order.stripe_customer_token,
            :destination => {
              :amount => @amount_seller ,
              :account => (@order.seller.stripe_account.acct_id),
            }
          })
        rescue Stripe::CardError => e
          charge_error = e.message
        end
        if charge_error
          flash[:error] = charge_error
          redirect_to '/'
        else

          if @video_order.save
            @order.update_column(:order_status, 2)
            format.html { redirect_to @order, notice: 'Video was successfully uploaded!' }
            format.json { render :show, status: :created, location: @video_order }
          else
            format.html { render :new }
            format.json { render json: @video_order.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end

  # PATCH/PUT /video_orders/1
  # PATCH/PUT /video_orders/1.json
  def update
    respond_to do |format|
      if @video_order.update(video_order_params)
        format.html { redirect_to order_path(@video_order.order_id), notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_order }
      else
        format.html { render :edit }
        format.json { render json: @video_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_orders/1
  # DELETE /video_orders/1.json
  def destroy
    @video_order.destroy
    respond_to do |format|
      format.html { redirect_to video_orders_url, notice: 'Video order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_order
      @video_order = VideoOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_order_params
      params.require(:video_order).permit(:video, :order_id)
    end
end
