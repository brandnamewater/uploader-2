class Buyer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  #has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  #has_many :orders, dependent: :destroy


end
