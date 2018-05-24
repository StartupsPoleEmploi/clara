class CacheService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def CacheService.set_instance(the_double)
    @@the_double = the_double
  end

  def CacheService.get_instance
    @@the_double.nil? ? CacheService.new : @@the_double
  end

  def initialize
    @expire_time = 10.minutes
  end

  def expire_time
    @expire_time
  end

  def write(id, thing)
    Rails.cache.write(id, thing, {expires_in: @expire_time}) unless Rails.env.test?
  end

  def read(id)
     Rails.cache.read(id) unless Rails.env.test?
  end

  def delete(name)
     Rails.cache.delete(name) unless Rails.env.test?
  end

end
