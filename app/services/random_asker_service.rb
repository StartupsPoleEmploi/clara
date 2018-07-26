
class RandomAskerService
  
  def initialize
  end

  def go
    asker = Asker.new
    asker.v_handicap = ["oui", "non"].sample
    asker.v_spectacle = ["oui", "non"].sample
    asker.v_age = Array(17..69).map(&:to_s).sample
    asker.v_allocation_type = ["ARE_ASP", "ASS_AER_ATA_APS_AS-FNE", "RSA", "RPS_RFPA_RFF_pensionretraite", "AAH", "pas_indemnise"].sample
    asker.v_allocation_value_min = Array(1..3000).map(&:to_s).sample
    asker.v_diplome = ["niveau_1","niveau_2","niveau_3","niveau_4","niveau_5","niveau_infra_5"].sample
    asker.v_category = ["cat_12345","autres_cat"].sample
    asker.v_duree_d_inscription = ["plus_d_un_an","moins_d_un_an","non_inscrit"].sample
    asker.v_location_citycode = Array(10000..99999).map(&:to_s).sample.to_s
    asker
  end
  
end
