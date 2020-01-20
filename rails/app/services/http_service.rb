require 'uri'
require 'net/http'
require 'json'
require 'timeout'

class HttpService

  def post_form(uri, params)
    begin
      Timeout::timeout(2) do
        Net::HTTP.post_form(uri, params)
      end
    rescue Exception => e 
     p "Net::HTTP post_form request failed with #{e.message}" unless Rails.env.test?
     return "timeout"
   end
 end

 def post(scheme, host, port, path, json_params , headers)
  begin
    Timeout::timeout(2) do
      http = Net::HTTP.new(host, port)
      http.use_ssl = true if scheme == 'https'
      http.post(path, json_params, headers)
    end
  rescue Exception => e 
   p "Net::HTTP POST request failed with #{e.message}" unless Rails.env.test?
   return "timeout"
 end
end

def get(uri)
  begin
    Timeout::timeout(2) do
      return Net::HTTP.get(uri)
    end
  rescue Exception => e 
   p "Net::HTTP GET request failed with #{e.message}" unless Rails.env.test?
   return "timeout"
 end
end

end
