# Implement methods used by all controllers
class ApplicationController < ActionController::API
  # exception handling in controller level
  include Api::V1::ExceptionConcern
end
