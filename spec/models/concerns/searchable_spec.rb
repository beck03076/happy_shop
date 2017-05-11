require 'rails_helper'

RSpec.describe Searchable, elasticsearch: true do
  let(:product) { FactoryGirl.build(:product, id: 1, name: 'awesome', category: 'awesomeness') }

  context 'Product becomes searchable if included' do
    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it '.create_or_update_index enqueues a job to index_job' do
      expect { product.create_or_update_index }.to have_enqueued_job(IndexJob).with('Product', 'index', 1)
    end

    it '.delete_index enqueues a job to index_job' do
      product.save
      Product.import force: true, refresh: true
      expect { product.delete_index }.to have_enqueued_job(IndexJob).with('Product', 'delete', 1)
    end
  end
end
