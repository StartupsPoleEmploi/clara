require "base64"

class Asker < ActiveType::Object

  attribute :v_handicap,                  :string
  attribute :v_harki,                     :string
  attribute :v_detenu,                    :string
  attribute :v_protection_internationale, :string
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

end
