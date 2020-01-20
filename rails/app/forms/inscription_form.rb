class InscriptionForm < ActiveType::Object

  attribute :value, :string
  validates :value, presence: true

end
