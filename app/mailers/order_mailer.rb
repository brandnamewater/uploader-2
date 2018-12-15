class OrderMailer < ApplicationMailer
  default from: 'from@example.com'

  def order_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order Confirmation Email')
  end

  # def order_email_charged(user, order)
  #   @user = user.buyer
  #   @order = order
  #   mail(to: @user.email, subject: 'Order Completion Email')
  # end

  def order_email_charged_buyer(user, order)
    @user = user
    @order = order
    mail(to: @order.buyer.email, subject: 'Order Completion Email')
  end

  def order_email_charged_seller(user, order)
    @user = user
    @order = order
    mail(to: @order.seller.email, subject: 'Order Completion Email')
  end

  def order_email_cancelled_buyer(user, order)
    @user = user
    @order = order
    mail(to: @order.buyer.email, subject: 'Order Cancellation Email')
  end

  def order_email_cancelled_seller(user, order)
    @user = user
    @order = order
    mail(to: @order.seller.email, subject: 'Order Cancellation Email')
  end

  # def order_email_charged_(buyer, order)
  #   @order.buyer_id = buyer
  #   @order = order
  #   mail(to: buyer.email, subject: 'Order Completion Email')
  # end


end
