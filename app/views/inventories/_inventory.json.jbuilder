json.extract! inventory, :id, :product_name, :price, :quantity, :type, :vendor, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
