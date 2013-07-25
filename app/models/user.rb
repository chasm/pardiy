class User < ActiveRecord::Base
  before_create :set_random_password
  before_save :encrypt_password
  
  # These are transient fields -- they are not persisted
  # So ActiveRecord has nothing to do with them. For this
  # reason, we must use Ruby's attr_accessor helper to
  # create getters and setters for them.
  attr_accessor :password, :password_confirmation
  
  # Hash the passed in password with the user's salt and
  # return true if it matches the user's hash (fish), false otherwise.
  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end
  
  # If born_on is set, return true if >= 18 years old, false if < 18,
  # and nil if born_on not set
  def is_minor?
    self.born_on > Date.today - 18.years if self.born_on
  end
  
  private
  
  # Automatically encrypt the passed in password (which is transient)
  # setting the user's salt and hash (fish), which are persistent.
  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end
  
  # Set a random password for new users (on create) if one is not
  # passed in (no user has a blank password). They can always reset
  # it using the password reset feature.
  def set_random_password
    if password.blank?
      password = password_confirmation = BCrypt::Engine.generate_salt
    end
  end
end
