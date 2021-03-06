class SaveAnswer

  def call(asker, session)
    

    if (asker.is_a?(Asker) && asker.attributes.any?{|k,v| v})

      if session[:saved_answer] == nil && session[:id_token] == nil && AnswerActivation.new.get_value

        Answer.new(
          handicap: asker.v_handicap,
          spectacle: asker.v_spectacle,
          cadre: asker.v_cadre,
          diplome: asker.v_diplome,
          category: asker.v_category,
          duree_d_inscription: asker.v_duree_d_inscription,
          allocation_value_min: asker.v_allocation_value_min,
          allocation_type: asker.v_allocation_type,
          age: asker.v_age,
          location_citycode: asker.v_location_citycode,
          location_zipcode: asker.v_location_zipcode,
        ).tap(&:save!)

        session[:saved_answer] = 'true'

      end

    end
    
  end
end
