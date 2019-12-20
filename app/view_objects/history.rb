class History < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def date_of(str)
    arr = str.split(" ")
    arr.insert(3, "à")
    arr.pop
    joined = arr.join(" ")
    cleaned = joined.delete_suffix('min')
    _remove_last_given_char_from_string(cleaned, ' ')
  end

  def _remove_last_given_char_from_string(str, char)
    reversed_array = str.reverse.split("")
    index_of_char_to_remove = reversed_array.find_index{|e| e == char}
    reversed_array.delete_at(index_of_char_to_remove)
    reversed_array.reverse.join("")
  end


end
