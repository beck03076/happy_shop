module Api
  module V1
    # public module can be accessed without authentication
    module Public
      # products controller to GET product and products
      class ProductsController < ApiController
        # concern to contain the products controller methods
        include ProductsControllerPublicConcern
        # sets product_search before index and products_count call
        before_action :set_product_search, only: %i[index products_count]

        # GET /api/v1/products.json
        #
        # renders json of products from elasticsearch
        def index
          products = @product_search
                     .products
                     .page(params[:page])
                     .per(params[:per_page])
                     .records

          render json: products, each_serializer: Api::V1::ProductSerializer
        end

        # GET /api/v1/products_count.json
        #
        # renders the total number of products in the system
        def products_count
          render json: { total_count: @product_search.products_count }
        end

        # GET /api/v1/products/:id.json
        #
        # renders serialized version of a single product
        def show
          render json: product, serializer: Api::V1::ProductSerializer
        end

        private

        # memoizes the products found by id
        def product
          @product ||= Product.find_by(id: params[:id])
        end

        # set the instance variable @product_search
        def set_product_search
          @product_search ||= ProductSearch.perform(search_params)
        end
      end
    end
  end
end
