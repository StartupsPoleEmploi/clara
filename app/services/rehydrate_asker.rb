class RehydrateAsker

  def call!(asker_attributes)
    unless _valid_args(asker_attributes)
      raise ArgumentError.new("Arguments must be attributes of an Asker")
    end
    HydrateAddress.call(asker_attributes)
    HydrateInscription.call(asker_attributes)
  end

  def _valid_args(asker_attributes)
    asker_attributes.is_a?(Hash) && Asker.new.attributes.keys.sort == asker_attributes.keys.sort
  end

end
