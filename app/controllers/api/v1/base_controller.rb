class Api::V1::BaseController < ApplicationController
  include Pagy::Backend

  rescue_from StandardError, with: :handle_internal_server_error

  private

  def handle_internal_server_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end
end
