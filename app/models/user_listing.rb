class UserListing < ApplicationRecord

  belongs_to :user
  belongs_to :listing

  validates :link, uniqueness: true
  
end
