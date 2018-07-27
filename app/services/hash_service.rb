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
    x.reject!{|k,v| 'id' == k.to_s || k.to_s.end_with?("_id")} if x.is_a? Hash
    if x.respond_to? :each
      x.each do |k,v| 
        if x[k].is_a? Hash
          x[k].each{|m,n| reject_ids! x[k]}
        elsif x[k].is_a? Array
          x[k].each{|e| reject_ids! e}  
        end
      end
    end
  end

end
