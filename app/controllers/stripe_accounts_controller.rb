class StripeAccountsController < ApplicationController
  layout 'admin'
  before_action :set_stripe_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /stripe_accounts
  # GET /stripe_accounts.json
  def index
    @stripe_accounts = StripeAccount.all
  end

  # GET /stripe_accounts/1
  # GET /stripe_accounts/1.json
  def show
    @user = current_user.id
    @stripe_account = StripeAccount.find(params[:id])

    @stripe_account_bank = Stripe::Account.retrieve(current_user.stripe_account.acct_id){
      :id

    @bank_account = @stripe_account_bank.external_accounts.retrieve(id)
  }
  end

  # GET /stripe_accounts/new
  def new
    @stripe_account = StripeAccount.new
    @user = User.find(params[:user_id])

  end

  # GET /stripe_accounts/1/edit
  def edit
    @user = User.find(params[:user_id])

    # Check for a valid account ID
    # unless params[:acct_id] && params[:id].eql?(current_user.stripe_token)
    #   flash[:error] = "No Stripe account specified"
    #   redirect_to dashboard_path and return
    # end

  # Retrieve the Stripe account to find fields needed
    # @stripe_account = Stripe::Account.retrieve(params[:acct_id])
    @stripe_account = Stripe::Account.retrieve(current_user.stripe_account.acct_id)

    # @stripe_account = Stripe::Account.retrieve(@stripe_account.acct_id)

    # @stripe_account = @user.stripe_token(stripe_account_params)

    # Retrieve the local account details
    @stripe_account = StripeAccount.find_by(params[:id])

    # if @stripe_account.verification.fields_needed.empty?
    #   flash[:success] = "Your information is all up to date."
    #   redirect_to dashboard_path and return
    # end
    # respond_to do |format|
    #
    #   format.html
    #
    #   format.js
    #
    # end
  end

  # POST /stripe_accounts
  # POST /stripe_accounts.json
  def create

    # @stripe_account = StripeAccount.new(stripe_account_params)
    # @user = User.find(params[:user_id])
    # @stripe_account.user_id = current_user.id

    @user = User.find(params[:user_id])
    @stripe_account = @user.build_stripe_account(stripe_account_params)



          acct = Stripe::Account.create({
          :country => "US",
          :type => "custom",
            legal_entity: {
              first_name: stripe_account_params[:first_name].capitalize,
              last_name: stripe_account_params[:last_name].capitalize,
              type: stripe_account_params[:account_type],
              dob: {
                day: stripe_account_params[:dob_day],
                month: stripe_account_params[:dob_month],
                year: stripe_account_params[:dob_year]
              },
              address: {
                line1: stripe_account_params[:address_line1],
                city: stripe_account_params[:address_city],
                state: stripe_account_params[:address_state],
                postal_code: stripe_account_params[:address_postal]
              },
              ssn_last_4: stripe_account_params[:ssn_last_4]
            },
            tos_acceptance: {
              date: Time.now.to_i,
              ip: request.remote_ip
            }

    })

    @stripe_account.acct_id = acct.id
    @user.stripe_token = acct.id



    respond_to do |format|

      # @user = User.find(params[:id])

      if @stripe_account.save! && @user.save




        format.html { redirect_to new_bank_account_path, notice: 'Stripe account was successfully created.' }
        format.json { render :show, status: :created, location: @stripe_account }


      else
        format.html { render :new }
        format.json { render json: @stripe_account.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /stripe_accounts/1
  # PATCH/PUT /stripe_accounts/1.json
  def update

    unless current_user.stripe_token
    redirect_to new_user_stripe_account_path and return
  end

  begin
    # Retrieve the Stripe account
    @stripe_account = Stripe::Account.retrieve(current_user.stripe_token)

    @stripe_account = StripeAccount.new(account_params)


    # Reject empty values
    account_params.each do |key, value|
      if value.empty?
        flash.now[:alert] = "Please complete all fields."
        render 'edit' and return
      end
    end

    # Iterate through each field needed
    @stripe_account.verification.fields_needed.each do |field|

      # Update each needed attribute
      case field
      when 'legal_entity.address.city'
        @stripe_account.legal_entity.address.city = account_params[:address_city]
      when 'legal_entity.address.line1'
        @stripe_account.legal_entity.address.line1 = account_params[:address_line1]
      when 'legal_entity.address.postal_code'
        @stripe_account.legal_entity.address.postal_code = account_params[:address_postal]
      when 'legal_entity.address.state'
        @stripe_account.legal_entity.address.state = account_params[:address_state]
      when 'legal_entity.dob.day'
        @stripe_account.legal_entity.dob.day = account_params[:dob_day]
      when 'legal_entity.dob.month'
        @stripe_account.legal_entity.dob.month = account_params[:dob_month]
      when 'legal_entity.dob.year'
        @stripe_account.legal_entity.dob.year = account_params[:dob_year]
      when 'legal_entity.first_name'
        @stripe_account.legal_entity.first_name = account_params[:first_name]
      when 'legal_entity.last_name'
        @stripe_account.legal_entity.last_name = account_params[:last_name]
      when 'legal_entity.ssn_last_4'
        @stripe_account.legal_entity.ssn_last_4 = account_params[:ssn_last_4]
      when 'legal_entity.type'
        @stripe_account.legal_entity.type = account_params[:type]
      when 'legal_entity.personal_id_number'
        @stripe_account.legal_entity.personal_id_number = account_params[:personal_id_number]
      when 'legal_entity.verification.document'
        @stripe_account.legal_entity.verification.document = account_params[:verification_document]
      when 'legal_entity.business_name'
        @stripe_account.legal_entity.business_name = account_params[:business_name]
      when 'legal_entity.business_tax_id'
        @stripe_account.legal_entity.business_tax_id = account_params[:business_tax_id]
      end
    end


    respond_to do |format|
      if @stripe_account.update(stripe_account_params)
        format.html { redirect_to @stripe_account, notice: 'Stripe account was successfully updated.' }
        format.json { render :show, status: :ok, location: @stripe_account }
      else
        format.html { render :edit }
        format.json { render json: @stripe_account.errors, status: :unprocessable_entity }
      end
    end
  end
end

  # DELETE /stripe_accounts/1
  # DELETE /stripe_accounts/1.json
  def destroy
    @stripe_account.destroy
    respond_to do |format|
      format.html { redirect_to stripe_accounts_url, notice: 'Stripe account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stripe_account
      @stripe_account = StripeAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stripe_account_params
      params.require(:stripe_account).permit(:first_name, :last_name, :account_type, :dob_month, :dob_day, :dob_year, :tos,
        :ssn_last_4, :address_line1, :address_city, :address_state, :address_postal, :business_name,
        :business_tax_id, :full_account, :personal_id_number, :verification_document, :acct_id, :user_id)
    end
end
