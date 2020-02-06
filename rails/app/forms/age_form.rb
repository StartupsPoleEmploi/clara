class AgeForm < ActiveType::Object

  attribute :number_of_years, :string

  validate :age_must_be_present
  validates :number_of_years, numericality: { only_integer: true }
  validate :age_must_be_greater_than_16
  validate :age_must_be_lower_than_70

  def age_must_be_present
    if number_of_years.blank?
      errors.add(:age_must_be_present, "L'information de l'âge est manquante")
    end 
  end

  def age_must_be_greater_than_16
    if number_of_years.to_i < 16
      errors.add(:age_must_be_greater_than_16, "L'âge doit être supérieur ou égal à 16 ans")
    end 
  end

  def age_must_be_lower_than_70
    if number_of_years.to_i > 70
      errors.add(:age_must_be_lower_than_70, "L'âge doit être inférieur ou égal à 70 ans")
    end 
  end

end
