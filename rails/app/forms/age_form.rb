class AgeForm < ActiveType::Object

  attribute :number_of_years, :string

  validates :number_of_years, presence: true
  validates :number_of_years, numericality: { only_integer: true, greater_than_or_equal_to: 16, less_than_or_equal_to: 70 }
end
