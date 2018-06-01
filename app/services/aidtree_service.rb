class AidtreeService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def AidtreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def AidtreeService.get_instance
    @@the_double.nil? ? AidtreeService.new : @@the_double
  end

  def initialize
    all_activated_aids = CacheService.get_instance.read("all_activated_aids")
    begin
      JSON.parse(all_activated_aids)
    rescue Exception => e
      all_activated_aids = Aid.activated.to_json
      CacheService.get_instance.write("all_activated_aids", all_activated_aids)
    ensure
      @all_activated_hash = JSON.parse(all_activated_aids)
    end
  end

  def go(asker)
    @all_activated_hash
  end

end
