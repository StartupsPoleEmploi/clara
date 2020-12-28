require "net/http"

class UrlExists

  def call(url_string)
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    if res.kind_of?(Net::HTTPRedirection)
      call(res['location']) # Go after any redirect and make sure you can access the redirected URL 
    else
      ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
    end
  rescue Errno::ENOENT   
    false #false if can't find the server 
  rescue URI::InvalidURIError   
    false #false if URI is invalid 
  rescue SocketError   
    false #false if Failed to open TCP connection 
  rescue Errno::ECONNREFUSED   
    false #false if Failed to open TCP connection 
  rescue Net::OpenTimeout   
    false #false if execution expired 
  rescue OpenSSL::SSL::SSLError   
    false
  end

end
