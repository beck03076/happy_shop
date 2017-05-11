require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'ProductsController' do
  let!(:products) { FactoryGirl.create_list(:product, 5) }
  let!(:makeup_products) { FactoryGirl.create_list(:product, 5, category: 'makeup') }
  let!(:tools_products) { FactoryGirl.create_list(:product, 5, category: 'tools') }
  let!(:makeup_product) { FactoryGirl.create(:product, category: 'makeup', price_cents: 1800) }
  let!(:tool_product) { FactoryGirl.create(:product, category: 'tools', price_cents: 1800) }
  let!(:makeup_product_1899) { FactoryGirl.create(:product, category: 'makeup', price_cents: 1899) }
  let!(:makeup_product_sale_999) { FactoryGirl.create(:product, category: 'makeup', sale_price_cents: 999) }
  let!(:lowest_price_product) { FactoryGirl.create(:product, price_cents: 100) }
  let!(:lowest_sale_price_product) { FactoryGirl.create(:product, sale_price_cents: 100) }
  let!(:highest_price_product) { FactoryGirl.create(:product, price_cents: 99_900, name: 'happy shop best product') }
  let!(:highest_sale_price_product) { FactoryGirl.create(:product, sale_price_cents: 99_900) }

  before do
    Product.import force: true, refresh: true
  end

  get '/api/v1/products/:id.json' do
    let(:id) { 1 }
    example 'Listing a single product' do
      explanation 'This fetches a single product from the system with the right attributes'
      do_request
      expect(status).to eq(200)
      expect(json_response.deep_symbolize_keys!).to include(:id, :name, :category, :sale_price, :price, :under_sale, :sold_out)
    end
  end

  get '/api/v1/products/:id.json' do
    let(:id) { 10_000_000 }
    example 'Trying to fetch a non existent product' do
      explanation 'This fetches a default no product from the system'
      do_request
      expect(status).to eq(200)
      expect(json_response['id']).to eq(nil)
      expect(json_response['name']).to eq('This product does not exist')
      expect(json_response['category']).to eq('N/A')
      expect(json_response['price']).to eq('N/A')
      expect(json_response['sale_price']).to eq('N/A')
      expect(json_response['sold_out']).to be_falsy
      expect(json_response['under_sale']).to be_falsy
    end
  end

  get '/api/v1/products_count.json' do
    example 'Getting the total product count in the system' do
      do_request
      expect(status).to eq(200)
      expect(json_response['total_count']).to eq(23)
    end
  end

  get '/api/v1/products' do
    example 'Listing products' do
      explanation 'This fetches all the products in the happy shop with the right attributes'
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(23)
      expect(json_response.sample.deep_symbolize_keys!).to include(:id, :name, :category, :sale_price, :price, :under_sale, :sold_out)
    end
  end

  get '/api/v1/products.pdf' do
    example 'raises an error for non json requests' do
      do_request
      expect(status).to eq(406)
      expect(json_response['message']).to eq('The request must be json format')
    end
  end

  post '/api/v1/products' do
    example 'raises an error for non GET requests' do
      do_request
      expect(status).to eq(406)
      expect(json_response['message']).to eq('Only get requests are allowed')
    end
  end

  get '/api/v1/products' do
    parameter :brand, 'An unsupported parameter by the api'
    let(:brand) { 'sony' }
    example 'raises an error for unsupported parameters' do
      do_request
      expect(status).to eq(400)
      expect(json_response['message']).to eq('These params are not supported')
      expect(json_response['unsupported_parameters']).to eq(['brand'])
    end
  end

  get '/api/v1/products' do
    parameter :query, 'Query to search on product name or category'
    let(:query) { 'happy shop best product' }

    example 'Listing products by search on product name and category' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(1)
      expect(json_response.first['name']).to eq('happy shop best product')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by'
    let(:categories) { 'makeup' }

    example 'Listing products filtered by a single category' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(8)
      expect(json_response.pluck('category').uniq).to include('makeup')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by as comma separated values'
    let(:categories) { 'makeup,tools' }

    example 'Listing products filtered by multiple categories' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(14)
      expect(json_response.pluck('category').uniq).to include('makeup', 'tools')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by as comma separated values'
    parameter :price_lte, 'Price lesser than or equal to'
    let(:categories) { 'makeup,tools' }
    let(:price_lte) { 19 }

    example 'Listing products filtered by multiple categories and price lesser than or eq to' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(3)
      expect(json_response.pluck('category').uniq).to include('makeup', 'tools')
      expect(json_response.pluck('price').uniq).to include('18.00 USD', '18.99 USD')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by as comma separated values'
    parameter :price_lte, 'Price lesser than or equal to'
    parameter :price_gte, 'Price greater than or equal to'
    let(:categories) { 'makeup,tools' }
    let(:price_lte) { 18.99 }
    let(:price_gte) { 18.99 }

    example 'Listing products filtered by multiple categories and price lesser/greater than or eq to' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(1)
      expect(json_response.pluck('category').uniq).to include('makeup')
      expect(json_response.pluck('price').uniq).to include('18.99 USD')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by as comma separated values'
    parameter :sale_price_lte, 'Sale Price lesser than or equal to'
    parameter :sale_price_gte, 'Sale Price greater than or equal to'
    let(:categories) { 'makeup' }
    let(:sale_price_lte) { 9.99 }
    let(:sale_price_gte) { 9.99 }

    example 'Listing products filtered by single category and sale price lesser/greater than or eq to' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(1)
      expect(json_response.pluck('category').uniq).to include('makeup')
      expect(json_response.pluck('sale_price').uniq).to include('9.99 USD')
    end
  end

  get '/api/v1/products' do
    parameter :sort_by, 'To be sorted by attribute and direction'
    let(:sort_by) { :lowest_price }

    example 'Listing products sorted by lowest price' do
      do_request
      expect(status).to eq(200)
      expect(json_response.first['price']).to eq('1.00 USD')
    end
  end

  get '/api/v1/products' do
    parameter :sort_by, 'To be sorted by attribute and direction'
    let(:sort_by) { :lowest_sale_price }

    example 'Listing products sorted by lowest sale price' do
      do_request
      expect(status).to eq(200)
      expect(json_response.first['sale_price']).to eq('1.00 USD')
    end
  end

  get '/api/v1/products' do
    parameter :sort_by, 'To be sorted by attribute and direction'
    let(:sort_by) { :highest_price }

    example 'Listing products sorted by highest price' do
      do_request
      expect(status).to eq(200)
      expect(json_response.first['price']).to eq('999.00 USD')
    end
  end

  get '/api/v1/products' do
    parameter :sort_by, 'To be sorted by attribute and direction'
    let(:sort_by) { :highest_sale_price }

    example 'Listing products sorted by highest sale price' do
      do_request
      expect(status).to eq(200)
      expect(json_response.first['sale_price']).to eq('999.00 USD')
    end
  end

  get '/api/v1/products' do
    parameter :page, 'Page number of the paginated results'
    parameter :per_page, 'Number of results per page'
    parameter :sort_by, 'To be sorted by attribute and direction'

    let(:sort_by) { :highest_sale_price }
    let(:page) { 1 }
    let(:per_page) { 1 }

    example 'Listing products as paginated' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(1)
      expect(json_response.first['sale_price']).to eq('999.00 USD')
    end
  end

  get '/api/v1/products' do
    parameter :categories, 'List of categories to be filtered by as comma separated values'
    parameter :price_gte, 'Price greater than or equal to'
    parameter :sort_by, 'To be sorted by attribute and direction'
    parameter :page, 'Page number of the paginated results'
    parameter :per_page, 'Number of results per page'

    let(:sort_by) { :highest_sale_price }
    let(:categories) { 'makeup,tools' }
    let(:price_gte) { 18.99 }
    let(:page) { 1 }
    let(:per_page) { 1 }

    example 'Listing products in combinations of all filters and sort' do
      do_request
      expect(status).to eq(200)
      expect(json_response.size).to eq(1)
    end
  end
end
