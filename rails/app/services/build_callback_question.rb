class BuildCallbackQuestion

  def call(session, params, request)
    asker = PullAskerFromSession.new.call(session)
    EnrichAskerFromParams.new.call(asker, params)
  end
  
end
