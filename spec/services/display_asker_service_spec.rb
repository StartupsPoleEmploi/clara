require 'rails_helper'

describe DisplayAskerService do

  describe '.go' do
    it 'Returns asker attritubes' do
      #given
      asker = Asker.new
      asker.v_handicap = 'v_handicap'
      asker.v_spectacle = 'v_spectacle'
      asker.v_cadre = 'v_cadre'
      asker.v_age = 'v_age'
      asker.v_diplome = 'v_diplome'
      asker.v_category = 'v_category'
      asker.v_duree_d_inscription = 'v_duree_d_inscription'
      asker.v_allocation_value_min = 'v_allocation_value_min'
      asker.v_allocation_type = 'v_allocation_type'
      asker.v_qpv = 'v_qpv'
      asker.v_zrr = 'v_zrr'
      asker.v_age = 'v_age'
      asker.v_location_label = 'v_location_label'
      asker.v_location_route = 'v_location_route'
      asker.v_location_city = 'v_location_city'
      asker.v_location_country = 'v_location_country'
      asker.v_location_zipcode = 'v_location_zipcode'
      asker.v_location_citycode = 'v_location_citycode'
      asker.v_location_street_number = 'v_location_street_number'
      asker.v_location_state = 'v_location_state'
      #when
      DisplayAskerService.new(asker).go
      #then
      expect(asker).to have_attributes({
        :v_handicap => "v_handicap",
        :v_spectacle => "v_spectacle",
        :v_cadre => 'v_cadre', 
        :v_age => 'v_age',
        :v_diplome => 'v_diplome',
        :v_category => 'v_category',
        :v_duree_d_inscription => 'v_duree_d_inscription',
        :v_allocation_value_min => 'v_allocation_value_min',
        :v_allocation_type => 'v_allocation_type',
        #:v_qpv => 'v_qpv',
        #:v_zrr => 'v_zrr',
        :v_location_label => 'v_location_label',
        :v_location_route => 'v_location_route',
        :v_location_city => 'v_location_city',
        :v_location_country => 'v_location_country',
        :v_location_zipcode => 'v_location_zipcode',
        :v_location_citycode => 'v_location_citycode',
        :v_location_street_number => 'v_location_street_number',
        :v_location_state => 'v_location_state'
      })
    end
  end

end
 
