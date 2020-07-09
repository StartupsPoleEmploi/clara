class BuildMetaFromPeconnect
  
  def call(h)
    h[:info].slice('given_name')
  end

end
