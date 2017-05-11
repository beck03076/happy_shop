require 'rails_helper'

RSpec.describe Api::V1::ProductSerializer do
  let(:product) { FactoryGirl.build(:product, price_cents: 900, created_at: 1.month.ago) }

  context 'serializes the product object the right way' do
    subject { JSON.parse(Api::V1::ProductSerializer.new(product).to_json) }

    it 'includes all the right attributes' do
      expect(subject).to include('id', 'name', 'category', 'under_sale', 'sold_out', 'price', 'sale_price', 'created_at', 'updated_at')
    end

    it 'serializes created_at(time) and price(money) as handled in application_serializer' do
      expect(subject['created_at']).to eq('about 1 month')
      expect(subject['price']).to eq('9.00 USD')
    end
  end
end
