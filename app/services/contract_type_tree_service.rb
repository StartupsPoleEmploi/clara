class ContractTypeTreeService

  attr_reader :all_contract_types

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def ContractTypeTreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def ContractTypeTreeService.get_instance
    @@the_double.nil? ? ContractTypeTreeService.new : @@the_double
  end

  def initialize
    @all_contract_types = ContractType.all

    # all_contract_types_str = CacheService.get_instance.read("all_contract_types")
    # begin
    #   JSON.parse(all_contract_types_str)
    # rescue Exception => e
    #   all_contract_types_str = ContractType.all
    #   CacheService.get_instance.write("all_contract_types", all_contract_types_str)
    # ensure
    #   @all_contract_types = JSON.parse(all_contract_types_str)
    # end
  end

end
