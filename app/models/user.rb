class User < ActiveRecord::Base
  before_save :encrypt_password
  
  attr_accessor :password, :password_confirmation
  
  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end
  
  private
  
  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end
end
