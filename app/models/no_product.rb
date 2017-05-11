# inherits from product and this the null object for product with default values
#
# @see https://en.wikipedia.org/wiki/Null_Object_pattern
class NoProduct < Product
  # default values for a non existing product
  NAME = 'This product does not exist'.freeze
  CATEGORY = 'N/A'.freeze
  SOLD_OUT = false
  UNDER_SALE = false
  PRICE = 'N/A'.freeze
  SALE_PRICE = 'N/A'.freeze

  # @return [String]
  def name
    NAME
  end

  # @return [String]
  def category
    CATEGORY
  end

  # @return [Boolean]
  def sold_out
    SOLD_OUT
  end

  # @return [Boolean]
  def under_sale
    UNDER_SALE
  end

  # @return [Numeric]
  def price
    PRICE
  end

  # @return [Numeric]
  def sale_price
    SALE_PRICE
  end
end
