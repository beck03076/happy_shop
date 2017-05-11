# ProductSearch as a tableless rails model
# initialized with the attributes to be used for search
#
# Rails Tableless Model
#
# @see http://railscasts.com/episodes/193-tableless-model
class ProductSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :products, :products_count

  # initializes only with a block to set instance variables
  def initialize
    yield(self) if block_given?
  end

  class << self
    # Class method that instantiates a product_search object with input products
    # also sets the products_count with fetched products
    #
    # @return [ProductSearch] object with products and products_count
    def perform(params)
      results = Search::ProductIndex.search(params)
      new do |search|
        search.products = results
        search.products_count = results.total_count
      end
    end
  end

  # To be a tableless model
  def persisted?
    false
  end
end
