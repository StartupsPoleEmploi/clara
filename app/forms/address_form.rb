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

  validate :cannot_change_address_manually

  def cannot_change_address_manually

    if label.present? && !country.present? 
      errors.add(:cannot_change_address_manually, "Vous devez sélectionner une ville parmi celles proposées, si vous ne trouvez pas, mettez le code postal de la ville la plus proche ou passez à l'étape suivante.")
    end 
  end
end
