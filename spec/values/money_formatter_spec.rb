require 'rails_helper'

RSpec.describe MoneyFormatter do
  let(:product) { FactoryGirl.build(:product, price_cents: 100) }

  describe '.new' do
    it 'creates a value object for money formatting' do
      money_formatter = MoneyFormatter.new(product.price)
      expect(money_formatter.format).to eq('1.00 USD')
      expect(money_formatter.currency).to be_an_instance_of(Money::Currency)
      expect(money_formatter.amount).to eq('1.00')
    end
  end
end
