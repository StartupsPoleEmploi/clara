require 'rails_helper'

describe SitemapTypes do
  
  describe '.all_types' do
    it 'Should return an empty array if no locals are given' do
      sut = SitemapTypes.new(nil, nil)
      expect(sut.all_types).to eq([])
    end
    it 'Should return an empty array if locals[:types] is not given' do
      sut = SitemapTypes.new(nil, {})
      expect(sut.all_types).to eq([])
    end
    it 'Should return the types array if locals[:types] is given as array' do
      sut = SitemapTypes.new(nil, {types: [1,2,3]})
      expect(sut.all_types).to eq([1,2,3])
    end
  end

end
