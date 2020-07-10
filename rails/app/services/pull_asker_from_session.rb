class PullAskerFromSession

  def call(session)
    Asker.new(JSON.parse(session[:asker])) || Asker.new  
  end
  
end
  

