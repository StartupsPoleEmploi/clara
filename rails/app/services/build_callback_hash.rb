class BuildCallbackHash

  def call(session, params, request)
    
    fake = ExtractParam.new(params).call("fake")
    code = ExtractParam.new(params).call("code")
    base_url = "https://#{request.host}"    


    if _pull_or_stub_data_from_api?(session, fake, code)
      extraction_h = PeConnectExtraction.new.call(base_url, code, fake)
      asker = BuildAskerFromPeconnect.new.call(extraction_h.slice(:statut, :birth, :formation, :coord, :alloc))
      meta = BuildMetaFromPeconnect.new.call(extraction_h.slice(:info))
      SaveMetaToSession.new.call(session, meta)
      SaveAskerToSession.new.call(session, asker)
    else
      asker = PullAskerFromSession.new.call(session)
      p '- - - - - - - - - - - - - - PullAskerFromSession- - - - - - - - - - - - - - - -' 
      ap asker
      p ''
      meta = PullMetaFromSession.new.call(session)
    end


    {
      asker: asker,
      meta: meta,
      filters:  Filter.with_aid_attached
    }
  end
  
  def _pull_or_stub_data_from_api?(session, fake, code)
    (fake || code) && session[:meta].blank?
  end

end
