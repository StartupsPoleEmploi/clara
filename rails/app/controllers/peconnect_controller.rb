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
    params.inspect
    p ''
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
