class DetailController < ApplicationController

  after_action :save_asker

  def show
    @aid = Aid.activated.friendly.find_by(slug: params[:id])
    if (@aid == nil && current_user != nil)
      @aid = Aid.find_by(slug: params[:id])
    end
    if has_active_user
      existing = Rails.cache.read(params[:for_id])
      if (existing) # already in the cache, we dont have to calculate anything
        @asker = Asker.new(existing[:asker])
      else
        @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
        @asker = HydrateAsker.new.call(@asker.attributes)
      end
      @loaded = DetailService.new(@aid).hashified_eligibility_and_rules(@asker)
      RecordRegister.new.call(session, @asker, params[:id])
    else
      @loaded = DetailService.new(@aid).hashified_aid
    end
    raise SecurityError if @loaded[:aid] == nil
    # gon.loaded = @loaded # testing & debug purpose only
  end

  def post_feedback
    ap "posted !!!!!!!!!!!!!!!!!!!!!!!!!!"
    render json: {
      status: "ok"
    }
  end

  def has_active_user
    !!params[:for_id]
  end

end
