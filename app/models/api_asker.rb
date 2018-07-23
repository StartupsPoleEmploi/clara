require "base64"


# Validation of Asker differs when it is generated from API.
# However, the Asker remains the same.
# This is why a dedicated class is created for API validation.
class ApiAsker < Asker

  validates :v_age, numericality: { only_integer: true, greater_than_or_equal_to: 16, less_than_or_equal_to: 70 }, unless: Proc.new { |a| a.v_age.blank? }



end
