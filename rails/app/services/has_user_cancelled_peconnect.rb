class HasUserCancelledPeconnect

  def call(original_url)
    copy_url = original_url
    uri    = URI.parse(copy_url)
    query_params = CGI.parse(uri.query)
    query_params.size == 1 && !query_params['state'].blank?
  end

end
