require 'rails_helper'

RSpec.describe ProductSearch, type: :model do
  let!(:product) { FactoryGirl.create(:product, id: 1) }
  let!(:one_product) { FactoryGirl.create(:product, id: 2, category: 'one') }
  let!(:one_100_product) { FactoryGirl.create(:product, id: 3, category: 'one', price_cents: 100) }

  before do
    Product.import force: true, refresh: true
  end

  describe '.perform' do
    it 'performs a serch on the product index and sets products and products_count' do
      product_search = ProductSearch.perform(categories: 'one', price_lte: 1)
      expect(product_search.products.size).to eq(1)
      expect(product_search.products.records.first.id).to eq(3)
      expect(product_search.products_count).to eq(1)
    end
  end
end
