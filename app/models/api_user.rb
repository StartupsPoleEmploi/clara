class ApiUser < ApplicationRecord

  has_secure_password


  # See https://stackoverflow.com/questions/5781593/rails-devise-how-do-i-memcache-devises-database-requests-for-the-user-object
  
  after_save :invalidate_cache


  # See https://github.com/nsarno/knock/issues/161#issuecomment-408748264
  def to_token_payload
    { sub: id, class: self.class.to_s }
  end

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_payload payload
    user_id = payload["sub"]
    # Returns a valid user, `nil` or raise
    Rails.cache.fetch("apiuser:#{user_id}") { self.find(user_id) if payload['class'] && payload['class'] == to_s }
  end

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_request request
    return nil unless request.respond_to?(:params) && request.params["auth"] && request.params["auth"]["email"]
    email = request.params["auth"]["email"]
    Rails.cache.fetch("apiuser_email:#{email}") { self.find_by(email: email) }
  end
  
  private
  
  def invalidate_cache
    Rails.cache.delete("apiuser:#{id}")
    Rails.cache.delete("apiuser_email:#{email}")
  end
end
