class RecordRegister

  def call(session, asker, url)
    city_key = asker.v_location_citycode
    unless CookiePreference.new(current_session: session).ga_disabled?
      tracings = ActivatedModelsService.instance.tracings
      aid_filtered_tracings = _scan_tracings_aids(asker, tracings, url)
      aid_and_rule_filtered_tracings = _scan_tracings_rules(asker, aid_filtered_tracings)
      aid_and_rule_filtered_tracings.each do |e|
        t = Trace.new
        t.user = session.id.to_s
        t.url = url
        t.tracing_id = e[:tracing_id]
        t.save
      end
    end
  end
  
  def _scan_tracings_aids(asker, tracings, url)
    tracings.select do |h|
      res = false
      if h["all_aids"]
        res = true
      else
        detection = h["aids"].detect do |aid|
          aid["slug"] == url
        end
        res = !!detection
      end
      res 
    end
  end

  def _scan_tracings_rules(asker, tracings)
    calculated_tracings = _calc_tracings_eligibility(asker, tracings)
    calculated_tracings.select { |s| s[:eligy] == "eligible"  }
  end

  def _calc_tracings_eligibility(asker, tracings)
    tracings.map do |h|
      {
        tracing_id: h["id"],
        eligy: RuletreeService.new.resolve(h["rule_id"], asker.attributes),
      }
    end
  end

end
