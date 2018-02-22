class AidService

  def initialize(aid)
    @aid = aid
    @aid_id = @aid ? @aid.id : nil
  end

  def self.all_eligible(asker)
    Aid.activated.select { |aid| self.new(aid)._eligible?(asker) } || []
  end

  def self.all_ineligible(asker)
    Aid.activated.select { |aid| self.new(aid)._ineligible?(asker) } || []
  end

  def self.all_uncertain(asker)
    Aid.activated.select { |aid| self.new(aid)._uncertain?(asker) } || []
  end

  def activated_and_eligible?(asker)
    return @aid && @aid.id && Aid.activated.where(:id => @aid.id).present? && _eligible?(asker)
  end

  def activated_and_ineligible?(asker)
    return @aid && @aid.id && Aid.activated.where(:id => @aid.id).present? && _ineligible?(asker)
  end

  def activated_and_uncertain?(asker)
    return @aid && @aid.id && Aid.activated.where(:id => @aid.id).present? && _uncertain?(asker)
  end

  def _eligible?(asker)
    @aid.rule.resolve(asker.attributes) == 'eligible'
  end

  def _ineligible?(asker)
    @aid.rule.resolve(asker.attributes) == 'ineligible'
  end

  def _uncertain?(asker)
    @aid.rule.resolve(asker.attributes) == 'uncertain'
  end
end
