class BuildCallbackHash

  def call(session, params, host)
    
    fake = params[:fake]
    code = params[:code]
    base_url = "https://#{host}"    

    if _pull_or_stub_data_from_api?(session, fake, code)
      extraction_h = PeConnectExtraction.new.call(session, base_url, code, fake)
      asker = BuildAskerFromPeconnect.new.call(extraction_h.slice(:statut, :birth, :formation, :coord, :alloc))
      meta = BuildMetaFromPeconnect.new.call(extraction_h.slice(:info))
      SaveMetaToSession.new.call(session, meta)
      SaveAskerToSession.new.call(session, asker)
    else
      asker = PullAskerFromSession.new.call(session)
      meta = PullMetaFromSession.new.call(session)
    end

    {
      asker: asker,
      meta: meta,
      filters:  Filter.with_aid_attached
    }
  end
  
  def _pull_or_stub_data_from_api?(session, fake, code)
    (fake || code) && session[:asker].blank?
  end

end
