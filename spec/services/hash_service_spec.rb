require 'rails_helper'

describe HashService do
  describe 'recursive_compact' do
    it 'should remove all empty elements from a hash' do
      #given
      hash_or_array = { "Jane Doe" => 2 , "Jim Doe" => nil }
      #when
      result = HashService.new.recursive_compact(hash_or_array)
      #then
      expect(result).to eq({ "Jane Doe" => 2 })
    end
  end
end

