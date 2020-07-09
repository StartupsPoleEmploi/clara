class BuildMetaFromPeconnect
  
  def call(h)
    res = {
      'given_name' => ''
    }
    if h.is_a?(Hash) && !h[:info].blank?
      res = h[:info].slice('given_name')
    end
    res
  end

end
