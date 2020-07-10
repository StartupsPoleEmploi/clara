class BuildCallbackHash

  def call(session, params, request)
    
    fake = ExtractParam.new(params).call("fake")
    code = ExtractParam.new(params).call("code")
    base_url = "https://#{request.host}"    

    asker = session[:asker] || Asker.new
    meta = session[:meta] || {}

    if _pull_or_stub_data_from_api?(fake, code)
      extraction_h = PeConnectExtraction.new.call(base_url, code, fake)
      asker = BuildAskerFromPeconnect.new.call(extraction_h.slice(:statut, :birth, :formation, :coord, :alloc))
      meta = BuildMetaFromPeconnect.new.call(extraction_h.slice(:info))
    end

    SaveAskerToSession.new.call(session, asker)
    SaveMetaToSession.new.call(session, meta)

    {
      asker: asker,
      meta: meta,
      filters:  Filter.with_aid_attached
    }

  end
  
  def _pull_or_stub_data_from_api?(fake, code)
    fake || code
  end

end
