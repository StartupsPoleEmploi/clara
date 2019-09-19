class CreateRienSaufDomTom

  def call(uuid)
    all_available_dom_tom_departments = [
     {"971" => "Guadeloupe"},
     {"972" => "Martinique"},
     {"973" => "Guyane"},
     {"974" => "La Réunion"},
     {"975" => "Saint-Pierre-et-Miquelon"},
     {"976" => "Mayotte"},
    ]
    regions = []
    towns = []

    CreateRienSauf.new.call(uuid, towns, all_available_dom_tom_departments, regions)

    
  end

end
