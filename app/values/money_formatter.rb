# value object for formatting money
class MoneyFormatter
  # new object
  #
  # @param money [Money]
  def initialize(money)
    @money = money.to_money
  end

  # formats to a string
  #
  # @return [String]
  def format
    "#{amount} #{currency}"
  end

  # to get the currency object of money
  #
  # @return [Money::Currency]
  def currency
    money.currency
  end

  # get the amount part of money
  #
  # @return [String]
  def amount
    money.format(symbol: false)
  end

  private

  attr_reader :money

  def usd?
    money.currency.iso_code == 'USD'
  end
end
