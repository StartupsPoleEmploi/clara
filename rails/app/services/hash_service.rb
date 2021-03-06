class HashService

  # based on https://stackoverflow.com/a/50471832/2595513
  def recursive_compact(hash_or_array)
    deep_copy = JSON.parse(hash_or_array.to_json)
    p = proc do |*args|
      v = args.last
      v.delete_if(&p) if v.respond_to? :delete_if
      v.nil? || (v.is_a?(String) && v.empty?)
    end

    deep_copy.delete_if(&p)
  end

  # Based on https://stackoverflow.com/a/35785227/2595513
  def reject_ids! x
    if x.is_a?(Array)
      x.each{|e| reject_ids! e}
    elsif x.is_a?(Hash)
      # x.reject!{|k,v| 'id' == k.to_s || k.to_s.end_with?("_id")}
      x.each do |k,v|
        if 'id' == k.to_s || k.to_s.end_with?("_id")
          x.delete(k) 
        elsif x[k].is_a? Hash
          x[k].each{|m,n| reject_ids! x[k]}
        elsif x[k].is_a? Array
          x[k].each{|e| reject_ids! e}  
        end
      end
    end 
            
  end

  # Based on https://stackoverflow.com/a/35785227/2595513
  def reject_keys_that_starts_with! x, val, count=0
    if x.is_a?(Array)
      x.each{|e| count = reject_keys_that_starts_with! e, val, count}  
    elsif x.is_a?(Hash)
      x_size_before = x.respond_to?(:size) ? x.size : 0
      !!x.reject!{|k,v| k.to_s.start_with?(val)}
      x_size_after = x.respond_to?(:size) ? x.size : 0
      count += x_size_before - x_size_after
      x.each do |k,v| 
        if x[k].is_a? Hash
          x[k].each{|m,n| count = reject_keys_that_starts_with! x[k], val, count}
        elsif x[k].is_a? Array
          x[k].each{|e| count = reject_keys_that_starts_with! e, val, count}  
        end
      end
    end
    count
  end

end
