class CreateFakeData

  def call
    User.create(email: "contributeur1@clara.com", password: "contributeur1", role: "contributeur")
    User.create(email: "relecteur1@clara.com", password: "relecteur1", role: "relecteur")
    User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")

    Filter.create!(name: "Se déplacer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)

    age_variable = Variable.find_or_create_by(name: 'v_age') do |var|
      var.name = "v_age"                   
      var.variable_kind = "integer"
      var.name_translation = "âge"
      var.is_visible = true
    end

    rule_a = Rule.create!({
      name: "r_fdsjmtrzunylagqc_box_1607963018482",
      value_eligible: "18",
      variable_id: age_variable.id,
      description: "Avoir un âge strictement supérieur à 18 ans",
      kind: "simple",
      operator_kind: "more_than",
      simulated: ""
    })

    rule_b = Rule.create!({
      name: "r_fdsjmtrzunylagqc_box_1607963030410",
      value_eligible: "28",
      variable_id: age_variable.id,
      description: "Avoir un âge strictement inférieur à 28 ans",
      kind: "simple",
      operator_kind: "less_than",
      simulated: ""
    })

    rule = Rule.create!({
      name: "r_fdsjmtrzunylagqc_root_box",
      composition_type: "or_rule",
      kind: "composite",
      slave_rules: [rule_a, rule_b]
    })

    Aid.create!(
      name: "Aide test mobilite", 
      status: "Publiée",
      contract_type: contract, 
      how_much: 'how much...',
      what: 'what...',
      how_and_when: 'how and when...',
      additionnal_conditions: 'additionnal conditions...',
      limitations: 'limitations...',
      short_description: 'short description...',
      rule: rule, 
      ordre_affichage: 3,
      archived_at: nil)


  end


end
