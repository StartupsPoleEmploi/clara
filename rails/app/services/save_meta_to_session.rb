class SaveMetaToSession

  def call(session, meta)
    session[:meta] = meta.to_s if meta    
  end
  
end

