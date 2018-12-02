class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :confirmable, :recoverable, :rememberable, :validatable,
          :trackable

        def active_for_authentication?
          super && approved
        end

        def inactive_message
          approved? ? super : :not_approved
        end

  enum role: { buyer: 1, seller: 2 }

  validates :name, presence: true

  has_one :listings, dependent: :destroy
  has_one :stripe_account
  accepts_nested_attributes_for :stripe_account
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  has_many :visits, class_name: "Ahoy::Visit"
  # has_many :sales_uploads, dependent: :destroy
  #has_many :orders, dependent: :destroy
  # has_many :orders
  #   protected
  # def confirmation_required?
  #   false
  # end

end
