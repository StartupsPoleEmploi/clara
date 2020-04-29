namespace :minidb do

  def fill_rules_array(rule_id, array_to_fill, all_rules)
    return if array_to_fill.include?(rule_id) 
    array_to_fill << rule_id
    current_rule = all_rules.find{|r| rule_id == r["id"]}

    if current_rule["slave_rules"].size > 0
      current_rule["slave_rules"].each do |slave_rule|
        fill_rules_array(slave_rule["id"], array_to_fill, all_rules)
      end
    end
  end

  task :recreate => :environment do
    p "Recreating a minidatabase from production data"
    activated_models = ActivatedModelsService.instance
    all_rules = activated_models.rules

    # Only a few aids
    Aid.where.not(
      slug:[
        "vsi-volontariat-de-solidarite-internationale",
        "erasmus",
        "illico-solidaire",
        "aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle",
        "autres-aides-nationales-pour-la-mobilite",
        "rps-remuneration-publique-des-stagiaires",
      ]).destroy_all


    # Only a few rules from the few aids
    root_rules_id = activated_models.aids.map { |aid| aid["rule_id"] }
    array_of_searched_rules = []
    root_rules_id.each do |root_rule_id|
      fill_rules_array(root_rule_id, array_of_searched_rules, all_rules)
    end
    p array_of_searched_rules
    ActiveRecord::Base.connection.disable_referential_integrity do
      Rule.where.not(id: array_of_searched_rules).destroy_all
    end

    # Only a few filters from the few aids
    raw_filters_id = activated_models.aids.map { |aid| aid["filters"].map { |f| f["id"] } }
    filters_id = raw_filters_id.flatten.uniq.sort
    Filter.where.not(id: filters_id).destroy_all

    # Only a few contract_types from the few aids
    raw_cts_id = activated_models.aids.map { |aid| aid["contract_type_id"] }
    cts_id = raw_cts_id.flatten.uniq.sort
    ContractType.where.not(id: cts_id).destroy_all

    # Only a few ZRR
    zrr_list = [
      "02004", # Agnicourt
      "49228", # Noyant-Villages
      "71469", # StPierreleVieux
    ]
    Zrr.destroy_all
    Zrr.new(value: zrr_list.join(",")).save

    # Only test apiuser
    test_apiuser_id = ApiUser.find_by(email: "foo@bar.com").id
    ApiUser.where.not(id: test_apiuser_id).destroy_all

    # Only test user
    User.destroy_all
    User.new(email:"superadmin@clara.com", password: "bar", role: "superadmin").save
    User.new(email:"contributeur1@clara.com", password: "contributeur1", role: "contributeur").save
    User.new(email:"contributeur2@clara.com", password: "Contributeur2+", role: "contributeur").save
    User.new(email:"relecteur1@clara.com", password: "relecteur1", role: "relecteur").save
    User.new(email:"relecteur2@clara.com", password: "relecteur2", role: "relecteur").save

    # No need to keep who did what
    PaperTrail::Version.destroy_all

    first_diff = Clockdiff.first
    unless first_diff
      first_diff = Clockdiff.new(value: 0)
      first_diff.save
    end

    # Remove statistics stuffs
    Feedback.destroy_all
    Trace.destroy_all
    Tracing.destroy_all
    Tracization.destroy_all

    # Remove pg_stats (5000 lines only for stats we don't need)
    ActiveRecord::Base.connection.exec_query("DROP EXTENSION pg_stat_statements;")
  end


  desc "Dumps the database to db/local.dump"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_dump --verbose --clean --no-acl --no-owner -h localhost --format=c ara_dev > #{Rails.root}/db/local.dump"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump from db/local.dump"
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d ara_dev #{Rails.root}/db/local.dump"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username]
  end


end
