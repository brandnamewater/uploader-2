class StripeAccount < ApplicationRecord
  validates :first_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :last_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :account_type,
  presence: true, inclusion: { in: %w(individual company), message: "%{value} is not a valid account type"}

  validates :tos,
  inclusion: { in: [ true ], message: ": You must agree to the terms of service" }

  belongs_to :user, optional: true

  belongs_to :affiliate, optional: true

  has_one :bank_account

  # validates :user_id, presence: true, uniqueness: true
  #
  # validates :affiliate_id, presence: true, uniqueness: true

end
