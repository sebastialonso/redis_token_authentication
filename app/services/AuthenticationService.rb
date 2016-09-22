module AutheticationService
  NotAuthorized = Class.new(Exception)

  module_function
  def authenticate_user(user, attempt)
    user && BCrypt::Engine.hash_secret(attempt, user.salt) == user.encrypt_password
  end

  def authenticate_user!(*args)
    authenticate_user(*args) or raise NotAuthorized
  end
end