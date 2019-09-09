class CreateScopeForAid

  def call(h)
    trundle = h[:scope][:trundle].with_indifferent_access
    aid = h[:aid]
    ap trundle
    ap aid
  end

  def _parse(obj, callback, _parent, _index)
    callback.call(obj, _parent, _index)
    if obj[:subboxes] && obj[:subboxes].size > 0
      obj[:subboxes].each_with_index do |subbox, x|
        _parse(subbox, callback, obj, x)
      end
    end
  end

end
# l = -> (obj, _p, _i) { puts "Merci #{obj[:name]}" }
