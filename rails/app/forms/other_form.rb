class OtherForm < ActiveType::Object

  attribute :val_spectacle, :string
  attribute :val_handicap, :string
  attribute :val_cadre, :string
  attribute :none, :string
  
  validate :needs_at_least_one_value

  def needs_at_least_one_value
    if !val_spectacle.present? && 
        !val_handicap.present? && 
        !val_cadre.present? && 
        !none.present?
      errors.add(:needs_at_least_one_value, 'Doit être rempli')
    end 
  end
end
