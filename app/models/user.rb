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


    # def invalidate_cache
    #   Rails.cache.delete("user:#{id}")
    # end
    # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_payload payload
    p '- - - - - - - - - - - - - - payload- - - - - - - - - - - - - - - -' 
    pp payload
    p ''
    # Returns a valid user, `nil` or raise
    # e.g.
    # ActivatedModelsService.new.users.find{|e| e.id == payload["sub"]}
    self.find payload["sub"]
  end

  # See https://github.com/nsarno/knock/blob/v2.1.1/README.md#customization
  def self.from_token_request request
    p '- - - - - - - - - - - - - - self.from_token_request- - - - - - - - - - - - - - - -' 
    email = request.params["auth"] && request.params["auth"]["email"]
    # ActivatedModelsService.new.users.find{|e| e.email == request.params["auth"]["email"]}
    self.find_by email: email
  end

end
