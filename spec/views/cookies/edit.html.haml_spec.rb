require 'rails_helper'

RSpec.describe "cookies/edit", type: :view do
  before(:each) do
    @cookie = assign(:cookie, Cookie.create!(
      :statistic => false,
      :navigation => false
    ))
  end

  it "renders the edit cookie form" do
    render

    assert_select "form[action=?][method=?]", cookie_path(@cookie), "post" do

      assert_select "input[name=?]", "cookie[statistic]"

      assert_select "input[name=?]", "cookie[navigation]"
    end
  end
end
