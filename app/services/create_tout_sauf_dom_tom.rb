class CreateToutSaufDomTom

  def call(uuid)

    all_available_dom_tom_departments = ["973", "971", "974", "976", "972", "975"]
    regions = []
    towns = []

    CreateToutSauf.new.call(uuid, towns, all_available_dom_tom_departments, regions)
    
  end

end
