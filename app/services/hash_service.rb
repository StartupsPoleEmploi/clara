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

  def recursive_id_removal(hash_or_array)
    deep_copy = JSON.parse(hash_or_array.to_json)
    p = proc do |*args|
      k = args.first
      k.delete_if(&p) if k.respond_to? :delete_if
      k.is_a?(String) && (k.end_with?("_id") || k == "id")
    end

    deep_copy.delete_if(&p)
  end

end
