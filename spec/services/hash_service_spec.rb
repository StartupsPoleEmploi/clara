require 'rails_helper'

describe HashService do
  describe 'recursive_compact' do
    it 'should remove all empty elements from a hash' do
      #given
      myHash = { "Jane Doe" => 2 , "Jim Doe" => nil }
      #when
      result = HashService.new.recursive_compact(myHash)
      #then
      expect(result).to eq({ "Jane Doe" => 2 })
    end
  end
  describe 'reject_ids!' do
    it 'should remove id and _id ' do
      #given
      x = {"my_id" => 1, "id" => 2, "anything else" => 3}
      #when
      result = HashService.new.reject_ids!(x)
      #then
      expect(result).to eq({"anything else" => 3})
    end
  end
end

