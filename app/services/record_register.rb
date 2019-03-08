class RecordRegister

  def call(session, asker, url)
    city_key = asker.v_location_citycode
    unless CookiePreference.new(current_session: session).ga_disabled?
      scans = _scan_tracings(asker)
      eligible_scans = scans.select { |s| s[:eligy] == "eligible"  }
      eligible_scans.each do |e|
        t = Trace.new
        t.user = session.id.to_s
        t.url = url
        t.tracing_id = s[:tracing_id]
        t.save
      end
    end
  end
  
  def _aids_tracings
    all_tracings = Rails.cache.fetch("all_tracings") do
      Tracing.all.map { |t| t.slice(:id, :rule_id) }
    end
  end

  def _scan_tracings(asker)
    res = {}
    all_tracings = Rails.cache.fetch("all_tracings") do
      Tracing.all.map { |t| t.slice(:id, :rule_id) }
    end
    res = all_tracings.map do |h|
      {
        tracing_id: h["id"],
        eligy: RuletreeService.resolve(h["rule_id"], asker.attributes),
      }
    end
  end

end
