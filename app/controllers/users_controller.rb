class UsersController < ApplicationController
layout "admin_dashboard", :only => [ :edit, :update, :new, :add_user ]
before_action :authenticate_user!

  def index
      if params[:approved] == "false"
        @users = User.where(approved: false)
      else
        @users = User.all
      end
    end

  def new
    @user = User.new
  end

  def add_user
    @user = User.new(user_params)
     if @user.save!
       redirect_to root_path
     end
  end




  def edit
    @user = User.find(params[:id])
    @stripe_account = StripeAccount.find(params[:id])

  end

  def show

  end


  def update
   @user = User.find(params[:id])
   if @user.update(user_params) # <- you'll need to define these somewhere as well
     respond_to do |format|
       format.html { redirect_to '/admin/users', notice: "yahoo" }
       format.json { render json: @user }
   else
       format.html { render :edit }
       format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
   end
 end




end




     private


     def user_params
       params.require(:user).permit(:name, :approved, :seller, :buyer, :admin, :stripe_account, :email, :password, :password_confirmation)
     end

     def user_seller_params
       params.require(:user).permit(:seller)
     end

end
