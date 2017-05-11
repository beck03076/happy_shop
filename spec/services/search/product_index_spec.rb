require 'rails_helper'

RSpec.describe Search::ProductIndex do
  let!(:product) { FactoryGirl.create(:product, id: 1) }
  let!(:one_product) { FactoryGirl.create(:product, id: 2, category: 'one') }
  let!(:one_100_product) { FactoryGirl.create(:product, id: 3, category: 'one', price_cents: 100) }

  before do
    Product.import force: true, refresh: true
  end

  describe '.search' do
    it 'performs a serch on the product index' do
      search = Search::ProductIndex.search(categories: 'one', price_lte: 1).results

      expect(search.size).to eq(1)
      expect(search.to_a.first.id).to eq('3')
      expect(search.to_a.first.category).to eq('one')
      expect(search.to_a.first.price_cents).to eq(100)
    end
  end
end
