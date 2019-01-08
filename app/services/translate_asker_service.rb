
class TranslateAskerService
  

  def to_french(api_asker)
    asker = Asker.new
    asker.v_spectacle            = boolean_to_french(api_asker.v_spectacle)
    asker.v_handicap             = boolean_to_french(api_asker.v_handicap)
    asker.v_cadre                = boolean_to_french(api_asker.v_cadre)
    asker.v_diplome              = diploma_to_french(api_asker.v_diplome)
    asker.v_category             = category_to_french(api_asker.v_category)
    asker.v_duree_d_inscription  = inscription_period_to_french(api_asker.v_duree_d_inscription)
    asker.v_allocation_type      = allocation_type_to_french(api_asker.v_allocation_type)
    asker.v_allocation_value_min = integer_to_french(api_asker.v_allocation_value_min)
    asker.v_age                  = integer_to_french(api_asker.v_age)
    asker.v_location_citycode    = integer_to_french(api_asker.v_location_citycode)
    asker.v_zrr                  = boolean_to_french(api_asker.v_zrr)
    asker
  end
  
  def from_french(api_asker)
    res = {}
    res[:spectacle]                = boolean_from_french(api_asker.v_spectacle)
    res[:disabled]                 = boolean_from_french(api_asker.v_handicap)
    res[:executive]                = boolean_from_french(api_asker.v_cadre)
    res[:diploma]                  = diploma_from_french(api_asker.v_diplome)
    res[:category]                 = category_from_french(api_asker.v_category)
    res[:inscription_period]       = inscription_period_from_french(api_asker.v_duree_d_inscription)
    res[:zrr]                      = api_asker.v_zrr
    res[:allocation_type]          = allocation_type_from_french(api_asker.v_allocation_type)
    res[:monthly_allocation_value] = integer_from_french(api_asker.v_allocation_value_min)
    res[:age]                      = integer_from_french(api_asker.v_age)
    res[:location_citycode]        = integer_from_french(api_asker.v_location_citycode)
    res[:zrr]                      = boolean_from_french(api_asker.v_zrr)
    res
  end
  
  def integer_to_french(the_int)
    return unless the_int != nil
    return the_int.to_s
  end
  def integer_from_french(the_int)
    integer_to_french(the_int)
  end

  def diploma_to_french(diploma)
    return unless diploma != nil
    diploma_hash[diploma.to_s.to_sym]
  end
  def diploma_from_french(diploma)
    return unless diploma != nil
    diploma_hash.invert[diploma.to_s].to_s
  end
  def diploma_hash
    {level_1: "niveau_1", level_2: "niveau_2", level_3: "niveau_3", level_4: "niveau_4", level_5: "niveau_5", level_below_5: "niveau_infra_5"}
  end

  def boolean_to_french(other)
    return unless other != nil
    boolean_hash[other.to_s.to_sym]
  end
  def boolean_from_french(other)
    return unless other != nil
    boolean_hash.invert[other.to_s].to_s
  end
  def boolean_hash
    {true: "true", false: "false"}
  end


  def category_to_french(category)
    return unless category != nil
    category_hash[category.to_s.to_sym]
  end
  def category_from_french(category)
    return unless category != nil
    category_hash.invert[category.to_s].to_s
  end
  def category_hash
    {categories_12345: "cat_12345", other_categories: "autres_cat"}
  end

  def inscription_period_to_french(period)
    return unless period != nil
    inscription_hash[period.to_s.to_sym]
  end
  def inscription_period_from_french(period)
    return unless period != nil
    inscription_hash.invert[period.to_s].to_s    
  end
  def inscription_hash
    {more_than_a_year: "plus_d_un_an", less_than_a_year: "moins_d_un_an", not_registered: "non_inscrit"}
  end

  def allocation_type_to_french(allocation_type)
    return unless allocation_type != nil
    allocation_hash[allocation_type.to_s.to_sym]
  end
  def allocation_type_from_french(allocation_type)
    return unless allocation_type != nil
    allocation_hash.invert[allocation_type.to_s].to_s    
  end

  def allocation_hash
    {
      ARE_ASP: "ARE_ASP", 
      ASS_AER_APS_ASFNE: "ASS_AER_APS_AS-FNE", 
      RPS_RFPA_RFF_PENSION: "RPS_RFPA_RFF_pensionretraite",
      RSA: "RSA", 
      AAH: "AAH", 
      none: "pas_indemnise"
    }
  end

end
