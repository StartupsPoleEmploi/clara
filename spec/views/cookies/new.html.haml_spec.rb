require 'rails_helper'

RSpec.describe "cookies/new", type: :view do
  before(:each) do
    assign(:cookie, Cookie.new(
      :statistic => false,
      :navigation => false
    ))
  end

  it "renders new cookie form" do
    render

    assert_select "form[action=?][method=?]", cookies_path, "post" do

      assert_select "input[name=?]", "cookie[statistic]"

      assert_select "input[name=?]", "cookie[navigation]"
    end
  end
end
