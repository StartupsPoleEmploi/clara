class PullMetaFromSession

  def call(session)
    session[:meta] || {}
  end
  
end
  

