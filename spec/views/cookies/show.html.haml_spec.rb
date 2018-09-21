require 'rails_helper'

RSpec.describe "cookies/show", type: :view do
  before(:each) do
    @cookie = assign(:cookie, Cookie.create!(
      :statistic => false,
      :navigation => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
