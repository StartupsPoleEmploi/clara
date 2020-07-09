class BuildAskerFromPeconnect
  
  def call(peconnect_data)
    p '- - - - - - - - - - - - - - peconnect_data- - - - - - - - - - - - - - - -' 
    pp peconnect_data
    p ''
    res = Asker.new
    res
  end

end
