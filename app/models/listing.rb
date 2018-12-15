class Listing < ApplicationRecord
  mount_uploader :image, ImageUploader
  serialize :image, JSON # If you use SQLite, add this line.


#  validates attachment content type :image, :content type => /\Aimage\/.*\Z/

  validates :name, :description, :price, presence: true
#  validates :price, numericality: { greater than: 0 }
  validates_presence_of :image

  belongs_to :user
  has_and_belongs_to_many :categories  # belongs_to :categories_listings, required: false
  # has_and_belongs_to_many :category, required: false, :through => :categories_listings


  attr_accessor :new_category_name
  before_save :create_category_from_name

  # has_many :categories

  def create_category_from_name
    create_category(name: new_category_name) unless new_category_name.blank?
  end

  has_many :orders
  #has_many :orders through: :sales_uploads



  enum listing_status: { live: 1, hold: 2 }

  def self.search(search)
    where("name LIKE ?","%#{search}%")
  end

#   def self.categories(category_ids)
#   select(:id).distinct.
#     joins(:categories).
#     where('categories.id' => category_ids)
# end

end
