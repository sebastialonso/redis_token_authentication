class User < ActiveRecord::Base

  attr_accessor :password

  #This should support password update (creates new salt as well)
  before_save :encrypt_password
  after_save :clear_password


  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypt_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
end
