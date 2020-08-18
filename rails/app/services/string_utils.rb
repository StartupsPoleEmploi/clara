class StringUtils

  def upcase_first_downcase_others(str)
    res = ''
    if str.is_a?(String) && str.size > 0
      local_str = str.downcase
      res = local_str[0].upcase + local_str[1..-1]
    end
    res
  end

end
