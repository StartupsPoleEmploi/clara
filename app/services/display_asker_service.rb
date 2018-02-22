class DisplayAskerService

  def initialize(asker)
    @asker = asker
  end

  def go
    @asker.attributes.symbolize_keys
  end

end
