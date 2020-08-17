class StringUtils

  def upcase_first_downcase_others(str)
    local_str = str.downcase
    final_str = local_str[0].upcase + local_str[1..-1]
    final_str
  end

end
