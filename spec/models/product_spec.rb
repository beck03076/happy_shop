require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { FactoryGirl.create(:product, id: 1) }

  describe '.find_by' do
    it 'fetches a product if exists' do
      product = Product.find_by(id: 1)
      expect(product.id).to eq(1)
      expect(product).to be_an_instance_of(Product)
    end

    it 'fetches a no_product if product does not exist' do
      product = Product.find_by(id: 2)
      expect(product.id).to eq(nil)
      expect(product).to be_an_instance_of(NoProduct)
    end
  end
end
