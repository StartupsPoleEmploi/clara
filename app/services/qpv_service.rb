require 'net/http'
require 'json'

class QpvService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def QpvService.set_instance(the_double)
    @@the_double = the_double
  end

  def QpvService.get_instance
    @@the_double.nil? ? QpvService.new : @@the_double
  end

  def initialize
    @base_url = ENV['ARA_URL_QPVZRR']
  end

  def isDetailedQPV(num_adresse, nom_voie, code_postal, nom_commune)
    return "erreur_numero_manquant" if num_adresse.blank?
    4.times do
      res = _getQPV("#{num_adresse} #{nom_voie} #{code_postal} #{nom_commune}") 
      if res === 'work_in_progress'
        sleep(2) unless Rails.env.test?
      else  
        return res
      end
    end
    return 'erreur_injoignable'
  end

  def setDetailedQPV(num_adresse, nom_voie, code_postal, nom_commune)
    return false if num_adresse.blank? 
    return false if nom_voie.blank? 
    return false if code_postal.blank? 
    return false if nom_commune.blank? 
    full_url = "#{@base_url}/setqpv"
    uri = URI.parse(full_url)
    header = {'Content-Type': 'text/json'}   
    full_address = {
      num_adresse: num_adresse,
      nom_voie: nom_voie,
      code_postal: code_postal,
      nom_commune: nom_commune
    }  
    params = full_address
    json_headers = {"Content-Type" => "application/json",
                    "Accept" => "application/json"}
    uri = URI.parse(full_url)

    result = HttpService.get_instance.post(uri.scheme, uri.host, uri.port, uri.path, params.to_json, json_headers)
    return true
  end

  def _getQPV(address)
    full_url = "#{@base_url}/isqpv?q=#{address}"
    escaped_address = URI.escape(full_url) 
    uri = URI.parse(escaped_address)
    response = HttpService.get_instance.get(uri)

    if response && response.include?('is_qpv')
      return 'en_qpv'
    elsif response && response.include?('is_not_qpv')
      return 'hors_qpv'
    elsif response && response.include?('error')
      return 'est_indetermine'
    elsif response && response.include?('timeout')
      return 'service_indisponible'
    else
      return 'work_in_progress'
    end
  end

end
