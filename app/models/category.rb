class Category < ApplicationRecord
  # validates_uniqueness_of :category
  # has_many :listings
  # has_and_belongs_to_many :listings, :through => :categories_listings
  # has_and_belongs_to_many :categories_listings
  has_and_belongs_to_many :listings


  # CATEGORY = %w{ YouTubers Influencers Twitter Instagram Artists Actors }

  CATEGORIES = @categories
end
