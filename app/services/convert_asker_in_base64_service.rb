
class ConvertAskerInBase64Service
  
  def initialize
  end

  def into_base64(the_asker)
    # qpv and zrr are excluded
    asker_str = the_asker
      .attributes
      .sort_by{|k, _| k}
      .to_h
      .select { |key, value| key.to_s.match(/^v_/) }
      .delete_if { |key, value| key == :v_zrr ||  key == :v_qpv }
      .transform_values { |v| v.nil? ? 'nil' : v.to_s.force_encoding("utf-8") }
      .values
      .join(',')
    Base64.urlsafe_encode64(asker_str)
  end
  
  def from_base64(base64_str)
    res = Asker.new()
    hash = res
      .attributes
      .to_h
      .sort_by{|k, _| k}
      .to_h
      .select { |key, value| key.to_s.match(/^v_/) }
      .delete_if { |key, value| key == :v_zrr ||  key == :v_qpv }
    decoded = Base64.urlsafe_decode64(base64_str)
    values = decoded.split(',')
    values = values.map{ |v| v == 'nil' ? nil : v.to_s.force_encoding("utf-8") }
    init_with = hash.keys.zip(values).to_h
    Asker.new(init_with)
  end

end
