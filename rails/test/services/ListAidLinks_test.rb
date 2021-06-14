require "test_helper"

class ListAidLinksTest < ActiveSupport::TestCase
  

  test ".call, nominal" do
    #given
    create_aid_with_ftp_and_http_links
    create_aid_with_http_secured_links
    #when
    res = ListAidLinks.new.call
    #then
    assert_equal(
      [
        {:aid_slug=>"aaa", 
          :links=>["http://example2.com", "http://example1.com"]}, 

        {:aid_slug=>"bbb", 
          :links=>["https://example3.com", "https://example4.com"]}
      ], 
    res)
  end
  
  def create_aid_with_ftp_and_http_links
    c = ContractType.new(name: 'c1' + rand(36**8).to_s(36), ordre_affichage: 42).tap(&:save!)
    Aid.new("name"=>"aaa", 
        "what"=>"<p>ftp://ftp.is.co.za/rfc/rfc1808.txt</p>\r\n", 
        "additionnal_conditions"=>"<p>http://example1.com</p>\r\n", 
        "how_much"=>"<p>http://example2.com</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n",
        "ordre_affichage" => 9,
        "contract_type" => c).tap(&:save!)
  end
  def create_aid_with_http_secured_links
    c = ContractType.new(name: 'c2' + rand(36**8).to_s(36), ordre_affichage: 21).tap(&:save!)
    Aid.new("name"=>"bbb", 
        "what"=>"<p>https://example3.com</p><p>https://example4.com</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n",
        "ordre_affichage" => 12,
        "contract_type" => c).tap(&:save!)
  end

end
