
class TranslateB64AskerService
  

  def from_b64(asker_64)
    asker_array = Base64.urlsafe_decode64(asker_64).split(",")
    # p asker_array
    base_keys = base_h.keys.sort_by(&:itself)
    # p base_keys
    # https://stackoverflow.com/a/9137388/2595513
    asker_h = Hash[base_keys.zip(asker_array)] 
    # p asker_h
    asker = Asker.new
    asker.v_spectacle              = boolean_to_b64(asker_h["spectacle"])
    # asker.v_handicap             = boolean_to_b64(forid_asker.v_handicap)
    # asker.v_diplome              = diploma_to_b64(forid_asker.v_diplome)
    # asker.v_category             = category_to_b64(forid_asker.v_category)
    # asker.v_duree_d_inscription  = inscription_period_to_b64(forid_asker.v_duree_d_inscription)
    # asker.v_allocation_type      = allocation_type_to_b64(forid_asker.v_allocation_type)
    # asker.v_allocation_value_min = integer_to_b64(forid_asker.v_allocation_value_min)
    # asker.v_age                  = integer_to_b64(forid_asker.v_age)
    # asker.v_location_citycode    = integer_to_b64(forid_asker.v_location_citycode)
    p asker
    asker
  end
  
  def into_b64(asker)
    h = base_h
    h["spectacle"]                = boolean_from_b64(asker.v_spectacle)
    h["disabled"]                 = boolean_from_b64(asker.v_handicap)
    h["diploma"]                  = diploma_from_b64(asker.v_diplome)
    h["category"]                 = category_from_b64(asker.v_category)
    h["inscription_period"]       = inscription_period_from_b64(asker.v_duree_d_inscription)
    h["allocation_type"]          = allocation_type_from_b64(asker.v_allocation_type)
    h["monthly_allocation_value"] = integer_from_b64(asker.v_allocation_value_min)
    h["age"]                      = integer_from_b64(asker.v_age)
    h["location_citycode"]        = integer_from_b64(asker.v_location_citycode)
    p h
    Base64.urlsafe_encode64(h.keys.sort_by(&:itself).map{|e| h[e]}.join(','))
  end
  
  private

  def base_h
    h = {}
    h["spectacle"]                = ""
    h["disabled"]                 = ""
    h["diploma"]                  = ""
    h["category"]                 = ""
    h["inscription_period"]       = ""
    h["allocation_type"]          = ""
    h["monthly_allocation_value"] = ""
    h["age"]                      = ""
    h["location_citycode"]        = ""
    h
  end

  def integer_to_b64(the_int)
    return unless the_int != nil
    return the_int.to_s
  end
  def integer_from_b64(the_int)
    integer_to_b64(the_int)
  end

  def diploma_to_b64(diploma)
    return unless diploma != nil
    diploma_hash[diploma.to_s]
  end
  def diploma_from_b64(diploma)
    return unless diploma != nil
    diploma_hash.invert[diploma.to_s].to_s
  end
  def diploma_hash
    {"1" => "niveau_1", "2" => "niveau_2", "3" => "niveau_3", "4" => "niveau_4", "5" => "niveau_5", "6" => "niveau_infra_5"}
  end

  def boolean_to_b64(other)
    return unless other != nil
    boolean_hash[other.to_s]
  end
  def boolean_from_b64(other)
    return unless other != nil
    boolean_hash.invert[other.to_s].to_s
  end
  def boolean_hash
    {"o" => "oui", "n" => "non"}
  end


  def category_to_b64(category)
    return unless category != nil
    category_hash[category.to_s]
  end
  def category_from_b64(category)
    return unless category != nil
    category_hash.invert[category.to_s].to_s
  end
  def category_hash
    {"1" => "cat_12345", "o" => "autres_cat"}
  end

  def inscription_period_to_b64(period)
    return unless period != nil
    inscription_hash[period.to_s]
  end
  def inscription_period_from_b64(period)
    return unless period != nil
    inscription_hash.invert[period.to_s].to_s    
  end
  def inscription_hash
    {"p" => "plus_d_un_an", "m" => "moins_d_un_an", "n" => "non_inscrit"}
  end

  def allocation_type_to_b64(allocation_type)
    return unless allocation_type != nil
    allocation_hash[allocation_type.to_s]
  end
  def allocation_type_from_b64(allocation_type)
    return unless allocation_type != nil
    allocation_hash.invert[allocation_type.to_s].to_s    
  end
  def allocation_hash
    {
      "1" => "ARE_ASP", 
      "2" => "ASS_AER_ATA_APS_AS-FNE", 
      "3" => "RPS_RFPA_RFF_pensionretraite",
      "4" => "RSA", 
      "5" => "AAH", 
      "6" => "pas_indemnise"
    }
  end

end
