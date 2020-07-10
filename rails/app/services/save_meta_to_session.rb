class SaveMetaToSession

  def call(session, meta)
    session[:meta] = meta.to_json.to_s if meta    
  end
  
end

