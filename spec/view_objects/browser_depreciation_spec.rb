require 'rails_helper'

describe BrowserDepreciation do
  
  describe '.show_depreciation_warning?' do
    it 'Should respond even when badly initialized' do
      sut = BrowserDepreciation.new(nil, Date.new)
      expect(sut.show_depreciation_warning?).to eq(false)
    end
    it 'Should properly respond if properly initialized' do
      sut = BrowserDepreciation.new(nil, {browser: FakeBrowser.new})
      expect(sut.show_depreciation_warning?).to eq(false)
    end
    it 'Should show depreciation if there is a bad IE browser' do
      sut = BrowserDepreciation.new(nil, {browser: FakeBadIEBrowser.new})
      expect(sut.show_depreciation_warning?).to eq(true)
    end
    it 'Should show depreciation if there is a bad Firefox browser' do
      sut = BrowserDepreciation.new(nil, {browser: FakeBadFirefoxBrowser.new})
      expect(sut.show_depreciation_warning?).to eq(true)
    end
    it 'Should show depreciation if there is a bad Chrome browser' do
      sut = BrowserDepreciation.new(nil, {browser: FakeBadChromeBrowser.new})
      expect(sut.show_depreciation_warning?).to eq(true)
    end
  end

  class FakeBrowser
    def ie?(stuff)
      false
    end
    def firefox?(stuff)
      false
    end
    def chrome?(stuff)
      false
    end
  end

  class FakeBadIEBrowser < FakeBrowser
    def ie?(stuff)
      true
    end
  end

  class FakeBadFirefoxBrowser < FakeBrowser
    def firefox?(stuff)
      true
    end
  end

  class FakeBadChromeBrowser < FakeBrowser
    def chrome?(stuff)
      true
    end
  end

end
