require 'rails_helper'

RSpec.describe NoProduct, type: :model do
  describe '.new' do
    it 'creates a default no_product' do
      no_product = NoProduct.new
      expect(no_product.id).to eq(nil)
      expect(no_product.name).to eq('This product does not exist')
      expect(no_product.category).to eq('N/A')
      expect(no_product.price).to eq('N/A')
      expect(no_product.sale_price).to eq('N/A')
      expect(no_product.sold_out).to be_falsy
      expect(no_product.under_sale).to be_falsy
    end
  end
end
