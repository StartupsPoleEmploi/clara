class User < ApplicationRecord
  has_secure_password


  # See https://stackoverflow.com/questions/5781593/rails-devise-how-do-i-memcache-devises-database-requests-for-the-user-object
  
  # after_save :invalidate_cache

  # def self.serialize_from_session(key, salt)
  #   p '- - - - - - - - - - - - - - serialize_from_session- - - - - - - - - - - - - - - -' 
  #   p ''
  #   single_key = key.is_a?(Array) ? key.first : key
  #   Rails.cache.fetch("user:#{single_key}") { User.find(single_key) }
  # end

  after_save :invalidate_cache
    # def invalidate_cache
    #   Rails.cache.delete("user:#{id}")
    # end
    # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_payload payload
    # p '- - - - - - - - - - - - - - payload- - - - - - - - - - - - - - - -' 
    # pp payload
    # p ''
    user_id = payload["sub"]
    # Returns a valid user, `nil` or raise
    # e.g.
    # self.find payload["sub"]
    # ActivatedModelsService.get_instance.users.find{|e| e["id"] == payload["sub"]}
    Rails.cache.fetch("user:#{user_id}") { self.find(user_id) }
  end

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_request request
    # p '- - - - - - - - - - - - - - self.from_token_request- - - - - - - - - - - - - - - -' 
    return nil unless request.params["auth"] && request.params["auth"]["email"]
    email = request.params["auth"]["email"]
    # Rails.cache.fetch("user_email:#{email}") { User.find_by(email: email) }
    return nil if !ActivatedModelsService.get_instance.users.find{|u| u["email"] == email}
    Rails.cache.fetch("user_email:#{email}") { self.find_by(email: email) }
    # ActivatedModelsService.get_instance.users.find{|e| e["email"] == request.params["auth"]["email"]}
  end
  
  private
  
  def invalidate_cache
    Rails.cache.delete("user:#{id}")
    Rails.cache.delete("user_email:#{email}")
  end
end
