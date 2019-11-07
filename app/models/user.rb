class User < ApplicationRecord
  include Clearance::User

    enum role: {
      contributor: "contributor", 
      relector: "relector", 
      superadmin: "superadmin", 
    }
  
end
