class Api::BaseController < ActionController::Base

  CURRENT_VERSION_PATH = "v1".freeze

  def render_error(code=422, message="Something went wrong.")
    render json: {code: Rack::Utils::SYMBOL_TO_STATUS_CODE[code], message: message}.to_json, status: code
  end
end
