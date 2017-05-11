module Api
  module V1
    module Public
      # methods extracted out of products controller
      module ProductsControllerPublicConcern
        def create; end

        private

        def search_params
          params.permit(:categories, :price_lte, :price_gte,
                        :sale_price_lte, :sale_price_gte, :sort_by,
                        :query, :format, :page, :per_page)
        end
      end
    end
  end
end
