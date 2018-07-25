# Validation of Asker differs when it is generated from API.
# However, the Asker remains the same.
# This is why a dedicated class is created for API validation.
class ApiAsker < Asker

  validates :v_spectacle, inclusion: { in: %w(true false), message: "%{value} n'est pas une valeur parmis celles possibles (true, false)" } , unless: Proc.new { |a| a.v_spectacle.blank? }
  validates :v_handicap, inclusion: { in: %w(true false), message: "%{value} n'est pas une valeur parmis celles possibles (true, false)" } , unless: Proc.new { |a| a.v_handicap.blank? }
  validates :v_diplome, inclusion: { in: %w(level_1 level_2 level_3 level_4 level_5 level_below_5), message: "%{value} n'est pas une valeur parmis celles possibles (level_1, level_2, level_3, level_4, level_5, level_below_5)" } , unless: Proc.new { |a| a.v_diplome.blank? }
  validates :v_category, inclusion: { in: %w(categories_12345 other_categories), message: "%{value} n'est pas une valeur parmis celles possibles (categories_12345, other_categories)" } , unless: Proc.new { |a| a.v_category.blank? }
  validates :v_duree_d_inscription, inclusion: { in: %w(more_than_a_year less_than_a_year not_registered), message: "%{value} n'est pas une valeur parmis celles possibles (more_than_a_year, less_than_a_year, not_registered)" } , unless: Proc.new { |a| a.v_duree_d_inscription.blank? }
  validates :v_allocation_type, inclusion: { in: %w(ARE_ASP ASS_AER_ATA_APS_ASFNE RPS_RFPA_RFF_PENSION RSA AAH none), message: "%{value} n'est pas une valeur parmis celles possibles (ARE_ASP, ASS_AER_ATA_APS_ASFNE, RPS_RFPA_RFF_PENSION, RSA, AAH, none)" } , unless: Proc.new { |a| a.v_allocation_type.blank? }
  validates :v_allocation_value_min, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, unless: Proc.new { |a| a.v_allocation_value_min.blank? }
  validates :v_age, numericality: { only_integer: true, greater_than_or_equal_to: 16, less_than_or_equal_to: 70 }, unless: Proc.new { |a| a.v_age.blank? }
  validates :v_location_citycode, format: { with: /\A\d{5}\z/, message: "Uniquement 5 chiffres consécutifs pour ce champs" }, unless: Proc.new { |a| a.v_location_citycode.blank? }

end
