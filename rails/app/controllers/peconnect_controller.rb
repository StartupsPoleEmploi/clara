require 'digest/sha1'
class PeconnectController < ApplicationController

  def index

    incoming_uri = URI.parse(request.base_url)

    base_url = "https://#{incoming_uri.host}"
    state = Digest::SHA1.hexdigest(rand(1000000000).to_s)
    nonce = Digest::SHA1.hexdigest(rand(1000000000).to_s)

    clientid = ENV['ESD_CLIENTID']

    myparams = {
      'realm' => '/individu',
      'response_type'=>'code',
      'client_id'=>clientid,
      'scope'=>"application_#{clientid} api_peconnect-individuv1",
      'redirect_uri'=>"#{base_url}/peconnect_callback",
      'state'=>state,
      'nonce'=>nonce,
    }

#       $url=sprintf('https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize?%s',http_build_query($params));
    @built_url = 'https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize?'
    @built_url += myparams.to_query
    p '- - - - - - - - - - - - - - @built_url- - - - - - - - - - - - - - - -' 
    pp @built_url
    p ''



  end

  def callback
    p '- - - - - - - - - - - - - - callback- !!!!!! - - - - - - - - - - - - - - -' 

    incoming_uri = URI.parse(request.base_url)
    base_url = "https://#{incoming_uri.host}"
    all_params = params.permit(params.keys).to_h.with_indifferent_access
    clientid = ENV['ESD_CLIENTID']
    clientsecret = ENV['ESD_CLIENTSECRET']
    ap all_params
    p ''

    my_url = 'https://authentification-candidat.pole-emploi.fr/connexion/oauth2/access_token?realm=%2findividu'
    my_url_host = 'authentification-candidat.pole-emploi.fr'
    my_url_path = '/connexion/oauth2/access_token?realm=%2findividu'
    my_form_params = {
      # 'realm'=>'/individu',
      'grant_type' => "authorization_code",
      'code' => all_params[:code],
      'client_id' => clientid,
      'client_secret' => clientsecret,
      'redirect_uri'=>"#{base_url}/peconnect_callback",
    }

    ap my_form_params

    # my_http_client = http_client(my_url_host, 443)
    # ap post_form(my_http_client, my_url_path, my_form_params)
    my_uri = URI.parse(my_url)

    my_response = HttpService.new.post_form(my_uri, my_form_params)
    ap JSON.parse(my_response.body)
    ap 'form posted'
  end

  def post_form(http_client, path, form_params)
    encoded_form = URI.encode_www_form(form_params)
    headers = { content_type: "application/x-www-form-urlencoded" }
    http_client.request_post(path, encoded_form, headers)
  end

  def http_client(host, port)
    http_client = Net::HTTP.new(host, port)
    http_client.read_timeout = 10 # seconds
    http_client.use_ssl = true
    http_client
  end

end

# static function peConnectGetForwardUrl($quark,$uri)
#     {
#       $session=$quark->getSession();
#       $state=sha1(rand(0,1000000000));
#       $nonce=sha1(rand(0,1000000000));

#       $session->set('peconnect_connection',
#         array(
#           'STATE'=>$state,
#           'NONCE'=>$nonce,
#           'uri'=>$uri
#         ));

#       $params=array(
#         'realm'=>'/individu',
#         'response_type'=>'code',
#         'client_id'=>ESD_CLIENTID,
#         'scope'=>'application_'.ESD_CLIENTID.' email api_peconnect-individuv1 openid profile',
#         'redirect_uri'=>URL_BASE.'/peconnect_callback',
#         'state'=>$state,
#         'nonce'=>$nonce,
#         //'prompt'=>'none'
#       );
#       $url=sprintf('https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize?%s',http_build_query($params));
#       return $url;
#     }
