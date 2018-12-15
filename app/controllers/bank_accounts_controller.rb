class BankAccountsController < ApplicationController
  layout :determine_layout

  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  def new
    # Redirect if no stripe account exists yet
    unless (current_user || current_affiliate).stripe_account.acct_id
      redirect_to new_stripe_account_path and return
    end

    begin
      # Retrieve the account object for this user
      @stripe_account = Stripe::Account.retrieve((current_user || current_affiliate).stripe_account.acct_id )
      # @stripe_account = Stripe::Account.retrieve(@stripe_account.acct_id)

      @bank_account = BankAccount.new
      # @stripe_account = StripeAccount.find(params[:stripe_account_id])


    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      handle_error(e.message, 'new')

    # Handle any other exceptions
    rescue => e
      flash[:error] = e.message
    end
  end

  def create

    # require 'pry'
    # Redirect if no token is POSTed or the user doesn't have a Stripe account
    unless params[:token] && (current_user || current_affiliate).stripe_account.acct_id
      redirect_to new_bank_account_path and return
    end

    begin
      # Retrieve the account object for this user
      # Stripe.api_key = "sk_test_5RwdUKMOUYo1TQnbDAgPy0QG"
      token = params[:token]
      stripe_account = Stripe::Account.retrieve((current_user || current_affiliate).stripe_account.acct_id)
      # stripe_account.external_accounts.create({
      #   # :source => {
      #     :object => "bank_account",
      #     # :account_number => bank_account_number,
      #     :country => country,
      #     :currency => "USD",
      #     :account_holder_name => account_holder_name,
      #     :account_holder_type => account_holder_type,
      #     :routing_number => routing_number,
      #     :account_token => token ,
      #     # }
      #   })


      # Create the bank account
      stripe_account.external_account = params[:token]
      stripe_account.save

      # Success, send on to the dashboard
      flash[:success] = "Your bank account has been added!"
      redirect_to dashboard_path

      # @stripe_account = StripeAccount.find(params[:stripe_account_id])
      # @bank_account = @stripe_account.build_bank_accouns(params[:id])
      #
      # @bank_account.stripe_account_id = @stripe_account

      @bank_account = BankAccount.new(bank_account_params)
      @bank_account.save!

    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      # handler_for_rescue(e.message, 'new')
      flash[:error] = e.message


    # Handle any other exceptions
    rescue => e
      # handle_error(e.message, 'new')
      flash[:error] = e.message
    end
  end

  def edit

  end



  # binding.pry

  private

  def authenticate
    if current_affiliate != nil
     authenticate_affiliate!
    else
     authenticate_user!
    end
  end

  def determine_layout
    current_affiliate ? "affiliate_dashboard" : "admin"
  end

  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:country)
  end

end
