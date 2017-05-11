# main product class that acts as the ORM for products table
class Product < ApplicationRecord
  # enabling elasticsearch
  include Elasticsearch::Model
  # methods for search
  include ProductSearchConcern
  include ActiveModel::Serialization

  # making price and sale_price as money objects
  #
  # @see https://github.com/RubyMoney/money-rails
  monetize :price_cents, :sale_price_cents

  class << self
    # overriding the default find_by to return null object if absent
    #
    # @param opts [Hash]
    # @return [Product, NoProduct]
    def find_by(opts)
      super(id: opts[:id]) || NoProduct.new
    end
  end
end
