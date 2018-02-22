class OtherService

  def initialize(asker)
    @asker = asker
  end

  def download_from_asker
    other = OtherForm.new
    other.val_harki    =  @asker.v_harki         
    other.val_detenu   =  @asker.v_detenu         
    other.val_pi       =  @asker.v_protection_internationale         
    other.val_handicap =  @asker.v_handicap
    if @asker.v_harki == 'non' && @asker.v_detenu == 'non' && @asker.v_protection_internationale == 'non' && @asker.v_handicap == 'non'
        other.none = 'oui'
    end
    other
  end

  def upload_to_asker(other)
    @asker.v_harki                     = other.val_harki.nil?    ? 'non':'oui'
    @asker.v_detenu                    = other.val_detenu.nil?   ? 'non':'oui'
    @asker.v_protection_internationale = other.val_pi.nil?       ? 'non':'oui'
    @asker.v_handicap                  = other.val_handicap.nil? ? 'non':'oui'
  end

end
