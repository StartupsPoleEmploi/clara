class SaveAskerToSession

  def call(session, asker)
    session[:asker] = asker.attributes.to_json.to_s if asker    
  end
  
end

