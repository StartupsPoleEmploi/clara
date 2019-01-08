class OtherService

  def initialize(asker)
    @asker = asker
  end

  def download_from_asker
    other = OtherForm.new
    other.val_spectacle =  @asker.v_spectacle         
    other.val_handicap =  @asker.v_handicap
    other.val_cadre =  @asker.v_cadre
    if @asker.v_spectacle == "false" && @asker.v_handicap == "false" && @asker.v_cadre == "false"
        other.none = "true"
    end
    other
  end

  def upload_to_asker(other)
    @asker.v_spectacle  = other.val_spectacle.nil? ? "false" : "true"
    @asker.v_handicap   = other.val_handicap.nil? ? "false" : "true"
    @asker.v_cadre      = other.val_cadre.nil? ? "false" : "true"
  end

end
