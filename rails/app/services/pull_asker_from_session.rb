class PullAskerFromSession

  def call(session)
    res = Asker.new
    if IsValidJson.new.call(session[:asker])
      res = Asker.new(JSON.parse(session[:asker]))
    end
    res
  end
  
end
  

