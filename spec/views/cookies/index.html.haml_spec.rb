require 'rails_helper'

RSpec.describe "cookies/index", type: :view do
  before(:each) do
    assign(:cookies, [
      Cookie.create!(
        :statistic => false,
        :navigation => false
      ),
      Cookie.create!(
        :statistic => false,
        :navigation => false
      )
    ])
  end

  it "renders a list of cookies" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
