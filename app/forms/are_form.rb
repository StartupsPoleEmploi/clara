class AreForm < ActiveType::Object

  attribute :minimum_income, :string

  validates :minimum_income, presence: true
  validates :minimum_income, numericality: { only_integer: true, greater_than_or_equal_to: 0}
end
