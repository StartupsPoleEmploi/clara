class OtherForm < ActiveType::Object

  attribute :val_harki, :string
  attribute :val_detenu, :string
  attribute :val_pi, :string
  attribute :val_handicap, :string
  attribute :none, :string
  
  validate :needs_at_least_one_value

  def needs_at_least_one_value
    if !val_harki.present? && 
        !val_detenu.present? && 
        !val_pi.present? && 
        !val_handicap.present? && 
        !none.present?
      errors.add(:needs_at_least_one_value, 'Doit être rempli')
    end 
  end
end
