class Api::UsersController < ApiController
  skip_before_action :session_token_authenticate, only: [:create]

  def create
    @user = User.create user_params
    if @user.errors.empty?
      _created
    else
      # TODO Handle instance errors: _bad_request(@user.errors)
      _bad_request
    end
  end

  def me
    _render_user
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def _created message = "Success"
    render json: {message: message}, status: 201
  end

  def _render_user
    render json: { user: current_user.to_json }, status: 200
  end
end