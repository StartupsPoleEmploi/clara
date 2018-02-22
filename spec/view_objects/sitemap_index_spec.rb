require 'rails_helper'

describe SitemapIndex do
  
  describe '.generated_aides_sitemap_url' do
    it 'Should return aides_sitemap_url with HTTP if required' do
      sut = SitemapIndex.new(nil, {request: FakeNoSslRequest.new})
      expect(sut.generated_aides_sitemap_url).to eq("http://www.example.com/aides-sitemap.xml")
    end
    it 'Should return aides_sitemap_url with HTTPS if required' do
      sut = SitemapIndex.new(nil, {request: FakeSslRequest.new})
      expect(sut.generated_aides_sitemap_url).to eq("https://www.example.com/aides-sitemap.xml")
    end
  end
  describe '.generated_types_sitemap_url' do
    it 'Should return types_sitemap_url with HTTP if required' do
      sut = SitemapIndex.new(nil, {request: FakeNoSslRequest.new})
      expect(sut.generated_types_sitemap_url).to eq("http://www.example.com/types-aides-sitemap.xml")
    end
    it 'Should return types_sitemap_url with HTTPS if required' do
      sut = SitemapIndex.new(nil, {request: FakeSslRequest.new})
      expect(sut.generated_types_sitemap_url).to eq("https://www.example.com/types-aides-sitemap.xml")
    end
  end
  describe '.generated_detail_url' do
    it 'Should return detail_url with HTTP if required' do
      sut = SitemapIndex.new(nil, {request: FakeNoSslRequest.new})
      expect(sut.generated_detail_url('any')).to eq("http://www.example.com/aides/detail/any")
    end
    it 'Should return detail_url with HTTPS if required' do
      sut = SitemapIndex.new(nil, {request: FakeSslRequest.new})
      expect(sut.generated_detail_url('any')).to eq("https://www.example.com/aides/detail/any")
    end
  end
  describe '.generated_type_url' do
    it 'Should return type_url with HTTP if required' do
      sut = SitemapIndex.new(nil, {request: FakeNoSslRequest.new})
      expect(sut.generated_type_url('any')).to eq("http://www.example.com/aides/type/any")
    end
    it 'Should return type_url with HTTPS if required' do
      sut = SitemapIndex.new(nil, {request: FakeSslRequest.new})
      expect(sut.generated_type_url('any')).to eq("https://www.example.com/aides/type/any")
    end
  end

  class FakeRequest
    def host
      "http://www.example.com"
    end
  end

  class FakeSslRequest < FakeRequest
    def ssl?
      true
    end
  end

  class FakeNoSslRequest < FakeRequest
    def ssl?
      false
    end
  end

end
