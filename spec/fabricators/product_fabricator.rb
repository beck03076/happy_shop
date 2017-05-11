category_array = %w[makeup tools brushes lipsticks perfumes shavinglotions showercaps]

Fabricator(:product) do
  name             { FFaker::Product.product_name }
  sold_out         { FFaker::Boolean.sample }
  category         { category_array.sample }
  under_sale       { FFaker::Boolean.sample }
  price_cents      { rand(1900..2000) }
  sale_price_cents { rand(1800..1900) }
end
