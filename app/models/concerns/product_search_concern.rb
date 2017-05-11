# helps define the mappings for elasticsearch
module ProductSearchConcern
  extend ActiveSupport::Concern
  # module to contain search query builder
  include Searchable
  # class methods for the including class
  included do
    # index_name to be test__products for test env
    index_name 'test__' + model_name.collection.gsub(/\//, '-') if Rails.env.test?

    # mappings of the product model and product index
    settings do
      mappings dynamic: 'false' do
        indexes :name, type: 'string', index: :not_analyzed
        indexes :category, type: 'string', index: :not_analyzed
        indexes :sold_out, type: 'boolean'
        indexes :under_sale, type: 'boolean'
        indexes :sale_price_cents, type: 'float', index: :not_analyzed
        indexes :price_cents, type: 'float', index: :not_analyzed
        indexes :created_at, type: 'date'
      end
    end

    # callbacks for updating/deleting product index
    after_save :create_or_update_index
    after_destroy :delete_index
  end
end
