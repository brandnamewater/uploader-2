json.extract! stripe_account, :id, :created_at, :updated_at
json.url stripe_account_url(stripe_account, format: :json)
