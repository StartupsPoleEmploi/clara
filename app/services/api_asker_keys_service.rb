
class ApiAskerKeysService
  

  def asker_hash
    {
      v_spectacle: "spectacle",
      v_handicap: "disabled",
      v_diplome: "diploma",
      v_category: "category",
      v_duree_d_inscription: "inscription_period",
      v_allocation_type: "allocation_type",
      v_allocation_value_min: "monthly_allocation_value",
      v_age: "age",
      v_location_citycode: "location_citycode"
    }
  end
  
  def reverse_hash
    asker_hash.invert
  end
end
