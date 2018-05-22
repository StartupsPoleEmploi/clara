class RuletreeService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def RuletreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def RuletreeService.get_instance
    @@the_double.nil? ? RuletreeService.new : @@the_double
  end

  def initialize
    all_rules = CacheService.get_instance.read("all_rules")
    begin
      JSON.parse(all_rules)
    rescue Exception => e
      all_rules = Rule.all.to_json(:include => :slave_rules)
      CacheService.get_instance.write("all_rules", all_rules)
    ensure
      @all_rules = JSON.parse(all_rules)
    end
  end

  def resolve(rule_id)
  end

  def _all_rules
    @all_rules
  end

end
