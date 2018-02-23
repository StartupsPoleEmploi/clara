require 'rails_helper'
require 'spec_helper'

describe 'welcome/index' do 

  it 'Should render with correct namespace' do
    render 
    expect(rendered).to have_css('.c-newhome')
  end
    

end
