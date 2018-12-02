class Order < ApplicationRecord

  include ActiveModel::Dirty

  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.

  visitable

  # def set_success(format, opts)
  #   self.success = true
  # end
  #validates_presence_of :video
  # attr_accessor :stripe_card_token



  validates :name, presence: true

  def order_sales_relationship
    Order.where(id: SalesUpload.where(:order_id))
  end


  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  # belongs_to :seller, class_name: "User"
  belongs_to :seller, foreign_key: :seller_id, class_name: "User"

  has_one :video_order

#  belongs_to :buyer
  #has_one :sales_upload
  #has_one :sales_upload, :as => :video
  #has_many :sales_uploads

  enum order_status: { created: 1, charged: 2, cancelled: 3 }


    # def save_with_payment
    #   if valid?
    #     customer = Stripe::Customer.create(description: email, card: stripe_card_token)
    #     self.stripe_customer_token = customer.id
    #     # self.user.update_column(:customer_id, customer.id) # this is line 16
    #     save!
    #
    #         @amount = 111
    #
    #
    #         # customer = Stripe::Customer.create({
    #         #   :source  => 'tok_visa',
    #         #   :email => params[:stripeEmail],
    #         # })
    #
    #         Stripe::Charge.create({
    #                 :source  => 'tok_visa',
    #
    #           amount: @amount,
    #           currency: 'usd',
    #           customer: customer.id,
    #       })
    #     end
    #   rescue Stripe::InvalidRequestError => e
    #     logger.error "Stripe error while creating customer: #{e.message}"
    #     errors.add :base, "There was a problem with your credit card."
    #     false
    #   end

    # def process_payment
    #
    #   @amount = 1234
    #
    #   customer = Stripe::Customer.create({
    #     :source  => 'tok_visa',
    #     :email => email,
    #   })
    #
    #   charge = Stripe::Charge.create({
    #     amount: @amount,
    #     currency: 'usd',
    #     customer: customer.id,
    #     capture: false,
    # })
    #
    #
    #
    # end







end
