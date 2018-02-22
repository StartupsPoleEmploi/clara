require 'rails_helper'

describe SitemapAides do
  
  describe '.all_aides' do
    it 'Should return an empty array if no locals are given' do
      sut = SitemapAides.new(nil, nil)
      expect(sut.all_aides).to eq([])
    end
    it 'Should return an empty array if locals[:aides] is not given' do
      sut = SitemapAides.new(nil, {})
      expect(sut.all_aides).to eq([])
    end
    it 'Should return the aides array if locals[:aides] is given as array' do
      sut = SitemapAides.new(nil, {aides: [1,2,3]})
      expect(sut.all_aides).to eq([1,2,3])
    end
  end

end
