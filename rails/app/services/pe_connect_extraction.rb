class PeConnectExtraction < PeConnectService

  def call(base_url, code)
    access_token = PeConnectAccessToken.new.call(base_url, code)

    info = PeConnectInfo.new.call(access_token)
    statut = PeConnectStatut.new.call(access_token)
    birth = PeConnectBirthdate.new.call(access_token)
    formation = PeConnectFormation.new.call(access_token)
    coord = PeConnectCoord.new.call(access_token)
    alloc = PeConnectAlloc.new.call(access_token)

    res = 
      {info: info, 
        statut: statut, 
        birth: birth, 
        formation: formation, 
        coord: coord, 
        alloc: alloc}

    res
  end


 end
