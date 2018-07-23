require "base64"

# asker = Asker.new(v_age:"34", v_diplome:"level_3", v_handicap: "true", v_duree_d_inscription: "more_than_a_year", v_category: "more_than_a_year", v_allocation_type: "RSA")

class Asker < ActiveType::Object

  # validate :adulthood
  # validates :v_age, numericality: { only_integer: true, greater_than_or_equal_to: 16, less_than_or_equal_to: 70 }

  attribute :v_handicap,                  :string
  attribute :v_spectacle,                 :string
  attribute :v_diplome,                   :string
  attribute :v_category,                  :string
  attribute :v_duree_d_inscription,       :string
  attribute :v_allocation_value_min,      :string
  attribute :v_allocation_type,           :string
  attribute :v_qpv,                       :string
  attribute :v_zrr,                       :string
  attribute :v_age,                       :string
  attribute :v_location_label,            :string
  attribute :v_location_route,            :string
  attribute :v_location_city,             :string
  attribute :v_location_country,          :string
  attribute :v_location_zipcode,          :string
  attribute :v_location_citycode,         :string
  attribute :v_location_street_number,    :string
  attribute :v_location_state,            :string

  # Ability to compare 2 askers properly
  def ==(o)
    self.attributes.symbolize_keys == o.attributes.symbolize_keys 
  end

  # def adulthood
  #   errors.add(:v_age, :too_young, years_limit: 18) if v_age.to_i < 18
  # end

end
