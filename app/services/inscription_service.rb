class InscriptionService

  def initialize(asker)
    @asker = asker
  end

  def download_from_asker
    inscription = InscriptionForm.new
    inscription.value    =  @asker.v_duree_d_inscription         
    inscription
  end

  def upload_to_asker(inscription)
    @asker.v_duree_d_inscription = inscription.value
    if inscription.value == 'non_inscrit'
      @asker.v_category = 'not_applicable'
    end
  end

end
