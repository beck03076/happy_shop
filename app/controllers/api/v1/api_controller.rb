# api module that contains all the api classes
module Api
  # version 1 of the api module
  module V1
    # parent api controller for all versions
    class ApiController < ActionController::API
      # only json requests are allowed
      ALLOWED_FORMATS = [:json].freeze
      # only GET requests are allowed
      ALLOWED_METHODS = [:get].freeze
      # includes the exception concern for exception handling
      include Api::V1::ExceptionConcern
      # error messages
      JSON_FORMAT = 'The request must be json format'.freeze
      GET_METHOD = 'Only get requests are allowed'.freeze
      # called before every request
      prepend_before_action :require_format, :only_get

      private

      # validation for format
      #
      # @raise [not_acceptable] if request is not json
      def require_format
        render_error(JSON_FORMAT, :not_acceptable) unless
        ALLOWED_FORMATS.include?(request.format.to_sym)
      end

      # validation for method
      #
      # @raise [not_acceptable] if request is not GET
      def only_get
        render_error(GET_METHOD, :not_acceptable) unless
        ALLOWED_METHODS.include?(request.method_symbol)
      end
    end
  end
end
