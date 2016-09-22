class ApiController < ApplicationController

  rescue_from AuthenticationService::NotAuthorized with :_not_authorized
  before_action :session_token_authenticate!
  
  private

  # Access the user from everywhere under ApiController
  def signed_in?
    !!current_api_session_token.user
  end

  # Access the user from everywhere under ApiController
  def current_user
    current_api_session_token.user
  end

  def session_token_authenticate!
    return _not_authorized unless _authorization_header && current_api_session_token.valid?  #valid? comes from SessionToken
  end

  def current_api_session_token
    @current_api_session_token ||= SessionToken.new(_authorization_header)
  end

  def _authorization_header
    request.headers['Authorization']
  end

  def _not_authorized message = "Not Authorized"
    _render_error message, 401
  end

  def _not_found message = "Not Found"
    _render_error message, 404
  end

  def _bad_request message = "Invalid request parameters"
    _render_error message, 400
  end

  def _render_error message, status
    render json: { error: message }, status: status
  end
end