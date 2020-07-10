class PullMetaFromSession

  def call(session)
    JSON.parse(session[:meta]) || {}
  end
  
end
  

