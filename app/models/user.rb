class User < ApplicationRecord
  include Clearance::User

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end
  
end
