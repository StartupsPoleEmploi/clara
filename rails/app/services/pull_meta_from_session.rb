class PullMetaFromSession

  def call(session)
    res = {}
    if IsValidJson.new.call(session[:meta])
      res = JSON.parse(session[:meta])
    end
    res
  end
  
end
  

