module Api
  module V1
    # formatting of errors messages
    module ResponseMessagesConcern
      # renders json with message, options and status
      def render_error(message, status = :bad_request, options = {})
        render json: { message: message.to_s }.merge(options), status: status
      end

      # render_errors for already existing errors
      def render_errors(errors, status = :bad_request)
        error_message = errors.join(' ')
        render_error(error_message, status)
      end

      # errors from the active_record
      def render_errors_for(error_record)
        render_error(pretty_error_message(error_record))
      end

      # renders success message
      def render_success(message = nil)
        render json: { message: message }, status: :ok
      end
    end
  end
end
