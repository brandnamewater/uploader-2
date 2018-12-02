class OrderUpdateOrderStatusController < ApplicationController

  def update

    if @order.update(order_charge)
      @amount = (@order.order_price).to_i * 100
      @amount_seller = (@order.order_price).to_i * 75
      if @order.update(order_charge)
        if current_user.seller?
                      charge = Stripe::Charge.create({
                        :amount      => (@order.order_price).to_i * 100,
                        :description => 'Rails Stripe customer',
                        :currency    => 'usd',
                        :customer => @order.stripe_customer_token,
                        :destination => {
                          :amount => @amount_seller ,
                          :account => (@order.seller.stripe_token),
                        }
                      })
          @order.order_status = "charged"
          format.html { redirect_to ([@user, @order]), notice: 'Order was successfully uploaded.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end


  end

  private

  def order_status
    params.require(:order).permit(:order_status)
  end

end
