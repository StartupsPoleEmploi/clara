require 'rails_helper'

describe BrowserDepreciationService do

  describe "For testing purpose" do
    before do
      cache_layer = instance_double("BrowserDepreciationService")
      allow(cache_layer).to receive(:deprecated?).and_return('not_a_boolean_as_expected')
      BrowserDepreciationService.set_instance(cache_layer)
    end
    after do
      BrowserDepreciationService.set_instance(nil)
    end
    it '.deprecated? Can be stubbed easily' do
      sut = BrowserDepreciationService.get_instance(nil)
      output = sut.deprecated?
      expect(output).to eq('not_a_boolean_as_expected')
    end
  end
  describe '.deprecated?' do
    before do
      BrowserDepreciationService.set_instance(nil)
    end
    it 'Should return false if not properly initialized' do
      sut = BrowserDepreciationService.get_instance("irrelevant String")
      expect(sut.deprecated?).to eq(false)
    end
    it 'Should return true if browser is Internet Explorer < 11' do
      browser = instance_double("FakeBrowser")
      allow(browser).to receive(:ie?).with('<11').and_return(true)
      allow(browser).to receive(:chrome?).with('<55').and_return(false)
      allow(browser).to receive(:firefox?).with('<53').and_return(false)
      sut = BrowserDepreciationService.get_instance(browser)
      expect(sut.deprecated?).to eq(true)
    end
    it 'Should return true if browser is Chrome < 55' do
      browser = instance_double("FakeBrowser")
      allow(browser).to receive(:ie?).with('<11').and_return(false)
      allow(browser).to receive(:chrome?).with('<55').and_return(true)
      allow(browser).to receive(:firefox?).with('<53').and_return(false)
      sut = BrowserDepreciationService.get_instance(browser)
      expect(sut.deprecated?).to eq(true)
    end
    it 'Should return true if browser is Firefox < 53' do
      browser = instance_double("FakeBrowser")
      allow(browser).to receive(:ie?).with('<11').and_return(false)
      allow(browser).to receive(:chrome?).with('<55').and_return(false)
      allow(browser).to receive(:firefox?).with('<53').and_return(true)
      sut = BrowserDepreciationService.get_instance(browser)
      expect(sut.deprecated?).to eq(true)
    end
  end


  class FakeBrowser
    def ie?(stuff)
    end
    def firefox?(stuff)
    end
    def chrome?(stuff)
    end
  end

 
end
