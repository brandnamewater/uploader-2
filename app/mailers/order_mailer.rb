class OrderMailer < ApplicationMailer
  default from: 'from@example.com'

  def order_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order Confirmation Email')
  end

  def order_email_charged(user, order)
    @user = user
    @order = order
    mail(to: @order.email, subject: 'Order Completion Email')
  end


end
