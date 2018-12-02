class ChargesController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true
  before_action :set_order, only: [:show, :edit, :update, :destroy]
    respond_to :html, :js
  before_action :authenticate_user!


  def new
  end


  def create

    # binding.pry

    # Amount in cents
    # @order = Order.new
    # @listing = Listing.find(params[:listing_id])
    # respond_to do |format|
    #
    #   format.html
    #
    #   format.js
    #
    # end
    @amount = 500
    token = params[:stripeToken]
    payment_form = params[:payment_form]

    # customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #
    # )

    charge = Stripe::Charge.create({
      # :source  => params[:stripeToken],
      :source  => 'tok_visa',

      # :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end






end
