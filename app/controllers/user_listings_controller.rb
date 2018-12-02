class UserListingsController < ApplicationController
  before_action :set_user_listing, only: [:show, :edit, :update, :destroy]

  # GET /user_listings
  # GET /user_listings.json
  def index
    @user_listings = UserListing.all
  end

  # GET /user_listings/1
  # GET /user_listings/1.json
  def show
    listing = UserListingLink.find_by(link: params[:user_link]).listing
    redirect_to listings_path(listing)
  end

  # GET /user_listings/new
  def new
    @user_listing = UserListing.new
  end

  # GET /user_listings/1/edit
  def edit
  end

  # POST /user_listings
  # POST /user_listings.json
  def create
    @user_listing = UserListing.new(user_listing_params)

    respond_to do |format|
      if @user_listing.save
        format.html { redirect_to @user_listing, notice: 'User listing was successfully created.' }
        format.json { render :show, status: :created, location: @user_listing }
      else
        format.html { render :new }
        format.json { render json: @user_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_listings/1
  # PATCH/PUT /user_listings/1.json
  def update
    respond_to do |format|
      if @user_listing.update(user_listing_params)
        format.html { redirect_to @user_listing, notice: 'User listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_listing }
      else
        format.html { render :edit }
        format.json { render json: @user_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_listings/1
  # DELETE /user_listings/1.json
  def destroy
    @user_listing.destroy
    respond_to do |format|
      format.html { redirect_to user_listings_url, notice: 'User listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_listing
      @user_listing = UserListing.find(params[:id, :user_link])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_listing_params
      params.fetch(:user_listing, {})
    end
end
