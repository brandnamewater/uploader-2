class Affiliate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :confirmable, :recoverable, :rememberable, :validatable,
          :trackable

  has_one :stripe_account
  has_many :users
  
  def active_for_authentication?
    super && approved
  end

  def inactive_message
    approved? ? super : :not_approved
  end


end
