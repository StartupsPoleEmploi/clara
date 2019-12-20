class History < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def date_of(str)
    arr = str.split(" ")
    arr.insert(3, "à")
    arr.pop
    joined = arr.join(" ")
    joined.delete_suffix('min') 
  end


end
