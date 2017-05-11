module Api
  module V1
    # all the exception handling methods are defined
    module ExceptionConcern
      # formatting of exception messages
      include ResponseMessagesConcern
      extend ActiveSupport::Concern
      # error messages
      UNSUPPORT_PARAMS = 'These params are not supported'.freeze
      UNSUPPORT_ENDPOINT = 'This endpoint is not supported'.freeze

      included do
        # rescue from unallowed params in the url
        rescue_from(ActionController::UnpermittedParameters) do |pme|
          render_error(UNSUPPORT_PARAMS,
                       :bad_request,
                       unsupported_parameters: pme.params)
        end
        # rescue from unallowed endpoints
        rescue_from(ActionController::RoutingError) do
          render_error(UNSUPPORT_ENDPOINT, :bad_request)
        end
      end
    end
  end
end
