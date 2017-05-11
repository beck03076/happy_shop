require 'action_view'
require 'action_view/helpers'
# Define common logic for all serializers
class ApplicationSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  # attributes of the serializable model
  #
  # @param args [Hash]
  def attributes(*args)
    hash = super
    hash.each do |key, value|
      format_time!(hash, key, value)
      format_money!(hash, key, value)
    end
  end

  private

  # format time if the attribute is UTC
  #
  # @param hash [Hash]
  # @param key [Symbol]
  # @param value [Object]
  def format_time!(hash, key, value)
    hash[key] = time_ago_in_words(value) if value.respond_to?(:utc)
  end

  # return money value object if attribute is money
  #
  # @param hash [Hash]
  # @param key [Symbol]
  # @param value [Object]
  def format_money!(hash, key, value)
    hash[key] = MoneyFormatter.new(value).format if value.is_a? Money
  end
end
