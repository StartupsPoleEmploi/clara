class AddressForm < ActiveType::Object

  attribute :label, :string
  attribute :route, :string
  attribute :city, :string
  attribute :country, :string
  attribute :zipcode, :string
  attribute :citycode, :string
  attribute :street_number, :string
  attribute :state, :string

  attr_reader :value

  validate :address_must_be_present
  validate :cannot_change_address_manually


  def address_must_be_present

    if label.blank?
      errors.add(:address_must_be_present, "Le code postal est manquant")
    end 
  end

  def cannot_change_address_manually

    if label.present? && !country.present? 
      errors.add(:cannot_change_address_manually, "Vous devez sélectionner une ville parmi celles proposées, si vous ne trouvez pas, mettez le code postal de la ville la plus proche.")
    end 
  end
end
