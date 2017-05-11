module Api
  module V1
    # serializes the attributes of the product record
    class ProductSerializer < ApplicationSerializer
      # attributes to return in the json
      attributes :id,
                 :name,
                 :category,
                 :price,
                 :sale_price,
                 :under_sale,
                 :sold_out,
                 :created_at,
                 :updated_at
    end
  end
end
