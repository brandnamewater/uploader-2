json.extract! user_listing, :id, :created_at, :updated_at
json.url user_listing_url(user_listing, format: :json)
