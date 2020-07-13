class SaveAskerToSession

  def call(session, asker)
    p '- - - - - - - - - - - - - - SaveAskerToSession- - - - - - - - - - - - - - - -' 
    ap asker.attributes.to_json.to_s 
    p ''
    session[:asker] = asker.attributes.to_json.to_s if asker    
  end
  
end

