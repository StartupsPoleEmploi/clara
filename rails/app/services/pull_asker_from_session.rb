class PullAskerFromSession

  def call(session)
    p '- - - - - - - - - - - - - - session- - - - - - - - - - - - - - - -' 
    ap session[:asker]
    ap JSON.parse(session[:asker])
    p ''
    Asker.new(JSON.parse(session[:asker])) || Asker.new  
  end
  
end
  

