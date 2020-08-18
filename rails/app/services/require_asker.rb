class RequireAsker

  def call(session_h)
    res = Asker.new
    if _asker_exists?(session_h)
      res = Asker.new(JSON.parse(session_h[:asker].to_s))
    else
      session_h[:asker] = res.to_json.to_s
    end
    res
  end

  def _asker_exists?(session_h)
    !!session_h[:asker]
  end

end
