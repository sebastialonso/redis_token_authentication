class Api::SessionsController < ApiController
  skip_before_action :session_token_authenticate!, only: [:create]

  def create
    token = current_api_session_token #<-- called from ApiController
    if params[:email]
      @user = User.find_by(email: params[:email])
      token.user = @user if _supplied_valid_password?
    end

    render json: token.as_json
  end

  private
  def _supplied_valid_password?
    params[:password] && UserAuthenticationService.authenticate_user!(@user, params[:password])
  end
end