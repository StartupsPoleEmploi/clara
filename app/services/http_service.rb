require 'uri'
require 'net/http'
require 'json'
require 'timeout'

class HttpService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def HttpService.set_instance(the_double)
    @@the_double = the_double
  end

  def HttpService.get_instance
    @@the_double.nil? ? HttpService.new : @@the_double
  end

  def post_form(uri, params)
    begin
      Timeout::timeout(2) do
        res = Net::HTTP.post_form(uri, params)
      end
    rescue Exception => e 
     p "Net::HTTP post_form request failed with #{e.message}" unless Rails.env.test?
     return "timeout"
   end
 end

 def post(scheme, host, port, path, json_params , headers)
  p '- - - - - - - - - - - - - - post- - - - - - - - - - - - - - - -' 
  p scheme.inspect
  p host.inspect
  p port.inspect
  p path.inspect
  p json_params.inspect
  p headers.inspect
  p ''
  begin
    Timeout::timeout(2) do
      http = Net::HTTP.new(host, port)
      http.use_ssl = true if scheme == 'https'
      res = http.post(path, json_params, headers)
      p '- - - - - - - - - - - - - - POST res- - - - - - - - - - - - - - - -' 
      p res.inspect
      p ''
      data = JSON.parse(res.body)
      p '- - - - - - - - - - - - - - POST res.body parsed- - - - - - - - - - - - - - - -' 
      p data
      p ''
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
   p "Net::HTTP GET request failed with #{e.message}" 
   return "timeout"
 end
end

end
