class User < ApplicationRecord
  include Clearance::User

    enum role: {
      admin: "admin", 
      superadmin: "superadmin", 
    }
  
end
