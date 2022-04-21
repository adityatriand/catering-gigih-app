json.extract! order, :id, :email, :status_order, :total_price, :created_at, :updated_at
json.url order_url(order, format: :json)
