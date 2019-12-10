class IsNewAid

  def call(aid)
    unless aid.is_a?(Aid)
      raise ArgumentError.new("Only aid is allowed")
    end

    aid.updated_at == aid.created_at

  end

end
