require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test "Welcome : default page" do
    #given
    create_fulfilled_aid
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

  def create_fulfilled_aid
    Aid.new("name"=>"aaa", 
        "what"=>"<p>descr</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n").save
  end


end
