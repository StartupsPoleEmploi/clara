# == Schema Information
#
# Table name: users
#
#  id              :integer(8)      not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ApplicationRecord
  has_secure_password


  # See https://stackoverflow.com/questions/5781593/rails-devise-how-do-i-memcache-devises-database-requests-for-the-user-object
  
  after_save :invalidate_cache

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_payload payload
    user_id = payload["sub"]
    # Returns a valid user, `nil` or raise
    Rails.cache.fetch("user:#{user_id}") { self.find(user_id) }
  end

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_request request
    return nil unless request.respond_to?(:params) && request.params["auth"] && request.params["auth"]["email"]
    email = request.params["auth"]["email"]
    Rails.cache.fetch("user_email:#{email}") { self.find_by(email: email) }
  end
  
  private
  
  def invalidate_cache
    Rails.cache.delete("user:#{id}")
    Rails.cache.delete("user_email:#{email}")
  end
end
