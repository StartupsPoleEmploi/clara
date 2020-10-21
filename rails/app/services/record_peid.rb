class RecordPeid

  def call(claim_sub)
    Peid.new(value: claim_sub).tap(&:save!)
  end
  
end
