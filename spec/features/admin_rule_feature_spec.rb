require 'rails_helper'

feature 'admin rule' do 

  before(:each) do 
    ENV['ARA_SKIP_ADMIN_AUTH'] = "true"
  end 
  scenario 'When you access to Rules in the main menu' do
    visit admin_root_path
    find('.navigation__link[href="/admin/rules?locale=fr"]').click

    # The table is available
    expect(page.all('.js-rule-table').count).to print_eq 1,
      "Table of existing rules is displayed"

    expect(page.all('h1').first.text).to print_eq "Règles",
      "Should have a main title \"Règles\""

    expect(page.all('#search').count).to print_eq 1,
      "Search field is printed"

    expect(page.all('a[href="/admin/rules/new?locale=fr&rule_kind=simple"]').count).to print_eq 1,
      "You can create a simple rule"

    expect(page.all('a[href="/admin/rules/new?locale=fr&rule_kind=composite"]').count).to print_eq 1,
      "You can create a complex rule"


  end


  
end
