class HydrateAsker

  def call(asker_attributes)
    unless _valid_args(asker_attributes)
      raise ArgumentError.new("Arguments must be attributes of an Asker")
    end
    asker_with_adress = HydrateAddress.new.call(asker_attributes)
    asker_with_adress_and_inscription = HydrateInscription.new.call(asker_with_adress.attributes.with_indifferent_access)
    asker_with_adress_and_inscription
  end

  def _valid_args(asker_attributes)
    asker_attributes.is_a?(Hash) && Asker.new.attributes.keys.sort == asker_attributes.keys.sort
  end

end
