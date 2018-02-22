require 'rails_helper'

feature 'Browser depreciation' do 


  context 'Browser is deprecated' do
    before do
      browser_layer = instance_double("BrowserDepreciationService")
      allow(browser_layer).to receive(:deprecated?).and_return(true)
      BrowserDepreciationService.set_instance(browser_layer)      
    end
    scenario 'Show a warning if the browser is deprecated' do 
      visit root_path
      expect(page).to have_css ".c-browser-deprecated"
    end
    after do
      BrowserDepreciationService.set_instance(nil)
    end
  end

  context 'Browser is NOT deprecated' do
    before do
      browser_layer = instance_double("BrowserDepreciationService")
      allow(browser_layer).to receive(:deprecated?).and_return(false)
      BrowserDepreciationService.set_instance(browser_layer)      
    end
    scenario 'DONT show a warning if the browser is NOT deprecated' do 
      visit root_path
      expect(page).not_to have_css ".c-browser-deprecated"
    end
    after do
      BrowserDepreciationService.set_instance(nil)
    end
  end

end
