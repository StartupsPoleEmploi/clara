class User < ApplicationRecord
  include Clearance::User

    enum role: {
      contributeur: "contributeur", 
      relecteur: "relecteur", 
      superadmin: "superadmin", 
    }
  
end
