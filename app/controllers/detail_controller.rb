class DetailController < ApplicationController

  after_action :save_asker

  def show
    @aid = Aid.activated.friendly.find(params[:id])
    if has_active_user
      existing = CacheService.get_instance.read(params[:for_id])
      if (existing) # already in the cache, we dont have to calculate anything
        p '- - - - - - - - - - - - - - existing- - - - - - - - - - - - - - - -' 
        p existing.inspect
        p ''
        @asker = Asker.new(existing[:asker])
      else
        @asker = ConvertAskerInBase64Service.new.from_base64(params[:for_id])
        CalculateAskerService.new(@asker).calculate_zrr_qpv
      end
      @loaded = DetailService.new(@aid).hashified_eligibility_and_rules(@asker)
    else
      @loaded = DetailService.new(@aid).hashified_aid
    end
    gon.loaded = @loaded # testing & debug purpose only
  end

  def has_active_user
    !!params[:for_id]
  end

end
