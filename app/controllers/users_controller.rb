class UsersController < ApplicationController
layout "admin_dashboard", :only => [ :edit, :update, :new, :add_user ]
before_action :authenticate_user!, :only => [ :edit, :update, :new, :add_user ]
layout "affiliate_dashboard", :only => [ :show ]
before_action :make_sure_admin, :only => [:add_user]

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

    @user = User.find(params[:id])

    if current_affiliate == @user.affiliate
      @user = User.find(params[:id])
    else
      redirect_to '/', alert: "You don't have permission to access this page.  If this is a mistake, please contact the administrators."
    end

    @orders_h = Order.all.where(seller: @user ).where(order_status: [2] ).order('created_at DESC')

    @orders_month = @orders_h.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_h.all.group_by { |day|  day.created_at.beginning_of_day }
    # @orders_week = @orders_j.all.group_by { |week|  week.created_at.beginning_of_week }

  end


  def update
   @user = User.find(params[:id])
   respond_to do |format|
   if @user.update(user_params) # <- you'll need to define these somewhere as well

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
       params.require(:user).permit(:name, :approved, :seller, :buyer, :admin, :stripe_account, :email, :password, :password_confirmation, :role, :affiliate_id)
     end

     def user_seller_params
       params.require(:user).permit(:seller)
     end

     def make_sure_admin
       unless @user.admin?
         redirect_to '/'
       end
     end

end
