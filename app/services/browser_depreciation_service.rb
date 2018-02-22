class BrowserDepreciationService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def BrowserDepreciationService.set_instance(the_double)
    @@the_double = the_double
  end

  def BrowserDepreciationService.get_instance(browser)
    @@the_double.nil? ? BrowserDepreciationService.new(browser) : @@the_double
  end

  def initialize(browser)
    @browser = browser
  end

  def deprecated?
    if (@browser && @browser.respond_to?("ie?") && @browser.respond_to?("chrome?") && @browser.respond_to?("firefox?"))
      return @browser.ie?('<11') || @browser.chrome?('<55')  || @browser.firefox?('<53')
    end
    false
  end

end
