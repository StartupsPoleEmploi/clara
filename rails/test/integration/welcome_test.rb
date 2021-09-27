require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test "Welcome : default page" do
    #given
    _create_realistic_aid('aid_name') 
    #when
    get root_path
    #then
    assert_response :success
    rendered = @controller.view_assigns['raw_rendered']
    assert_not_nil rendered[:nb_of_active_aids]
    assert_not_nil rendered[:type_aides]
    assert_not_nil rendered[:type_dispositifs]
    assert_not_nil rendered[:all_home_filters]
    assert_not_nil rendered[:url_of_peconnect]
    assert_not_nil rendered[:is_peconnect_activated]
  end

  test "Welcome : terms" do
    #given
    _create_realistic_aid('aid_name')   
    #when
    get conditions_generales_d_utilisation_path
    #then
    assert_response :success
  end

  def create_fulfilled_aid
    Aid.new("name"=>"aaa", 
        "what"=>"<p>descr</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n").tap(&:save!)
  end

  def _create_realistic_aid(aid_name)
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: aid_name, contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
    filter = 
      Filter.new(
       name: "Percevoir une rémunération pendant la formation",
       description: 'any',
       slug: "percevoir-une-remuneration-pendant-la-formation",
       ordre_affichage: 3,
       icon:"<?xml version=\"1.0\" encoding=\"utf-8\"?><svg version=\"1.1\" id=\"Calque_1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\"\t viewBox=\"0 0 30 30\" style=\"enable-background:new 0 0 30 30;\" xml:space=\"preserve\"><style type=\"text/css\">\t.st0{fill:#454545;}</style><desc>Created with Sketch.</desc><g>\t<path class=\"st0\" d=\"M29.6,5.5c-0.8-2.9-3.3-5-6.3-5.3c-3-0.3-5.8,1.2-7.2,3.9c-1.3,2.6-1,5.6,0.7,7.9l-0.7,4.2\t\tc-0.1,0.3,0.1,0.7,0.4,0.9c0.2,0.1,0.3,0.2,0.5,0.2c0.2,0,0.3,0,0.5-0.1l3.1-1.9c0.4-0.3,0.6-0.8,0.3-1.2c-0.3-0.4-0.8-0.6-1.2-0.3\t\tl-1.4,0.8l0.5-2.6c0-0.3,0-0.5-0.2-0.7c-1.5-1.7-1.8-4.1-0.8-6.2c1-2,3.2-3.2,5.4-3c2.3,0.2,4.1,1.8,4.7,4c0.6,2.2-0.2,4.5-2,5.9\t\tc-0.4,0.3-0.5,0.9-0.2,1.3c0.3,0.4,0.9,0.5,1.3,0.2C29.4,11.5,30.4,8.4,29.6,5.5z\"/>\t<path class=\"st0\" d=\"M10.5,13.5c-3,0-5.4,2.4-5.4,5.4c0,3,2.4,5.4,5.4,5.4s5.4-2.4,5.4-5.4C15.9,15.9,13.5,13.5,10.5,13.5z\t\t M10.5,22.4c-2,0-3.6-1.6-3.6-3.6s1.6-3.6,3.6-3.6s3.6,1.6,3.6,3.6S12.5,22.4,10.5,22.4z\"/>\t<path class=\"st0\" d=\"M11.2,24.9C11.2,24.9,11.2,24.9,11.2,24.9c-2.9,0-5.6,1.4-7.1,3.6c-0.3,0.4-0.2,1,0.2,1.2\t\tc0.2,0.1,0.3,0.2,0.5,0.2c0.3,0,0.6-0.1,0.7-0.4c1.2-1.7,3.3-2.8,5.6-2.8c0,0,0,0,0,0c2.3,0,4.5,1.1,5.6,2.8\t\tc0.3,0.4,0.8,0.5,1.2,0.2c0.4-0.3,0.5-0.8,0.2-1.2C16.8,26.3,14.1,24.9,11.2,24.9z\"/>\t<path class=\"st0\" d=\"M22.3,16.6c-0.5,0-0.9,0.4-0.9,0.9V29c0,0.5,0.4,0.9,0.9,0.9s0.9-0.4,0.9-0.9V17.5\t\tC23.2,17,22.8,16.6,22.3,16.6z\"/>\t<path class=\"st0\" d=\"M13.4,6.4c0-0.5-0.4-0.9-0.9-0.9H1.9V4.7c0-1.6,1.2-2.8,2.7-2.8h9.1c0.5,0,0.9-0.4,0.9-0.9s-0.4-0.9-0.9-0.9\t\tH4.6c-2.5,0-4.5,2.1-4.5,4.6V29c0,0.5,0.4,0.9,0.9,0.9s0.9-0.4,0.9-0.9V7.3h10.6C13,7.3,13.4,6.9,13.4,6.4z\"/>\t<path class=\"st0\" d=\"M23.7,5.2c0.5,0,0.8-0.4,0.8-0.8c0-0.5-0.4-0.8-0.8-0.8c-1.9,0-3.6,1.4-4,3.3h-0.1c-0.5,0-0.8,0.4-0.8,0.8\t\ts0.4,0.8,0.8,0.8h0.1c0.4,1.9,2.1,3.3,4,3.3c0.5,0,0.8-0.4,0.8-0.8s-0.4-0.8-0.8-0.8c-1,0-2-0.7-2.3-1.7h2.3c0.5,0,0.8-0.4,0.8-0.8\t\ts-0.4-0.8-0.8-0.8h-2.3C21.8,5.9,22.7,5.2,23.7,5.2z\"/></g></svg>",
       is_hidden: false,
       author: "Kelly Sikkema sur Unsplash",
       ordre_affichage_home: 7,
       aids: [aid]
      ).tap(&:save!)
    aid
  end


end
