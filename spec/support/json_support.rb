module JsonSupport
  def json_response
    @json_response ||= resp_body.blank? ? {} : JSON.parse(resp_body)
  end

  private

  def resp_body
    # support both normal controller spec and acceptance spec
    defined?(response) ? response.body : response_body
  end
end
