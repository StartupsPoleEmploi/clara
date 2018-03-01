module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def index
        if current_user
          p '- - - - - - - - - - - - - - current_user- - - - - - - - - - - - - - - -' 
          p current_user.inspect
          p params[:v_duree_d_inscription]
          a = Asker.new(asker_params)
          p a.inspect
          p ''

        else
          p ' - - - - - - - -no current_user'
        end
      end

      def asker_params
        params.permit(:v_handicap, :v_harki, :v_detenu, :v_protection_internationale, :v_diplome, :v_category, :v_duree_d_inscription, :v_allocation_value_min, :v_allocation_type, :v_location_label, :v_qpv, :v_zrr, :v_age, :v_location_citycode, :v_location_country, :v_location_label, :v_location_route, :v_location_state, :v_location_street_number, :v_location_zipcode).to_h
      end


    end
  end
end
