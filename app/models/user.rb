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
    return nil unless request.params["auth"] && request.params["auth"]["email"]
    email = request.params["auth"]["email"]
    return nil if !ActivatedModelsService.instance.users.find{|u| u["email"] == email}
    Rails.cache.fetch("user_email:#{email}") { self.find_by(email: email) }
  end
  
  private
  
  def invalidate_cache
    Rails.cache.delete("user:#{id}")
    Rails.cache.delete("user_email:#{email}")
  end
end
