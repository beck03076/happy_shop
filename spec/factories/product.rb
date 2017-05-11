require 'ffaker'

FactoryGirl.define do
  factory :product do
    name             { FFaker::Product.product_name }
    sold_out         { FFaker::Boolean.sample }
    category         { 'default' }
    under_sale       { FFaker::Boolean.sample }
    price_cents      { rand(1901..2000) }
    sale_price_cents { rand(1800..1900) }
  end
end
