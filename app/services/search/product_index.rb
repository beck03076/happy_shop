# search related services are in this module
module Search
  # all actions to be performed on product_index
  class ProductIndex
    # available sort options
    SORT_BY_OPTIONS = [
      LOWEST_SALE_PRICE  = 'lowest_sale_price'.freeze,
      HIGHEST_SALE_PRICE = 'highest_sale_price'.freeze,
      LOWEST_PRICE  = 'lowest_price'.freeze,
      HIGHEST_PRICE = 'highest_price'.freeze
    ].freeze

    # available text fields indexed for searching
    TEXT_INDEX_FIELDS = %w(name category).freeze

    class << self
      # class method exposed for searching
      #
      # @param options [Hash] takes all the keys like query, sort_by, etc.,
      # @return [ElasticSearch::Model]
      def search(options = {})
        @@options = options
        Product.__elasticsearch__.search(
          query: query(options),
          sort: sort
        )
      end

      private

      # query builder for performing search
      #
      # @param options [Hash]
      # @return [Hash] final query
      def query(options = {})
        {
          filtered: {
            query: build_query(options[:query].to_s),
            filter: { and: { filters: filter } }
          }
        }
      end

      # builds the sort query for ElasticSearch
      #
      # @return [Array] sortable attributes
      def sort
        sort_by = []
        sort_by << sort_build(LOWEST_SALE_PRICE, 'sale_price_cents', 'asc')
        sort_by << sort_build(HIGHEST_SALE_PRICE, 'sale_price_cents', 'desc')
        sort_by << sort_build(HIGHEST_PRICE, 'price_cents', 'desc')
        sort_by << sort_build(LOWEST_PRICE, 'price_cents', 'asc')
        sort_by.compact
      end

      # builds the filter query
      #
      # @return [Array] filterable conditions
      def filter
        filters = []
        filters << { terms: { 'category' => @@options[:categories].split(',') } } if @@options[:categories].present?
        filters << filter_build('price_cents', 'gte', :price_gte)
        filters << filter_build('price_cents', 'lte', :price_lte)
        filters << filter_build('sale_price_cents', 'gte', :sale_price_gte)
        filters << filter_build('sale_price_cents', 'lte', :sale_price_lte)
        filters.compact
      end

      # helper for sort builder
      #
      # @param conditions [Symbol]
      # @param col [Symbol]
      # @params dir [Symbol]
      # @return [Hash]
      def sort_build(condition, col, dir)
        { col => dir } if @@options[:sort_by] == condition
      end

      # query builder for text search
      #
      # @return [Hash] query object
      def build_query(q)
        return { match_all: {} } if q.empty?
        {
          multi_match: {
            query: q,
            fields: TEXT_INDEX_FIELDS
          }
        }
      end

      # helper to build filter
      #
      # @param conditions [Symbol]
      # @param col [Symbol]
      # @params param [Symbol]
      # @return [Hash]
      def filter_build(col, condition, param)
        { range: { col => { condition => @@options[param].to_cents } } } if @@options[param].present?
      end
    end
  end
end
