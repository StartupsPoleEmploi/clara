require 'rails_helper'

describe HashService do
  describe 'recursive_compact' do
    it 'should remove all empty elements from a hash' do
      #given
      myHash = { "Jane Doe" => 2 , "Jim Doe" => nil, 3 => nil }
      #when
      result = HashService.new.recursive_compact(myHash)
      #then
      expect(result).to eq({ "Jane Doe" => 2 })
    end

    it 'should remove all empty element from an array' do
      #given
      myArray = ["Good", nil, "morning"]
      #when
      result = HashService.new.recursive_compact(myArray)
      #then
      expect(result).to eq(["Good", "morning"])
    end

    it 'should remove all empty element from an array in an hash' do
      #given
      myHashInAnArray = {"Good" => 4, "test" => ["Jim Doe", nil], 2 => nil}
      #when
      result = HashService.new.recursive_compact(myHashInAnArray)
      #then
      expect(result).to eq({"Good" => 4, "test" => ["Jim Doe"]})
    end

  end


  describe 'reject_ids!' do
    it 'should remove id and _id from an hash' do
      #given
      x = {"my_id" => 1, "id" => 2, "anything else" => 3}
      #when
      result = HashService.new.reject_ids!(x)
      #then
      expect(result).to eq({"anything else" => 3})
    end
    it 'should remove id and _id from a hash in a hash' do
      #given
      y = {"id" => 1, "hi" => {"id" => 2, "how" => 3}, "are you" => 5}
      #when
      result = HashService.new.reject_ids!(y)
      #then
      expect(result).to eq({"hi" => {"how" => 3}, "are you" => 5})
    end
    it 'should remove id and _id from an array in a hash' do
      #given
      z = { "good morning" => 1, "id" => 2, "test" => [ {"my_id" => 4}, 3 ], "your_id" => [42] }
      #when
      result = HashService.new.reject_ids!(z)
      #then
      expect(result). to eq( {"good morning"=>1, "test" => [ {}, 3 ] })
    end
  end


  describe 'reject_keys_that_starts_with!' do
    it 'should count keys that starts with some value in a hash' do
      #given
      x = {"my_test" => 1, "something special" => 42, "my test" => 2, "my other test" => 3, "the chosen one" => 4}
      val = "my"
      #when
      result = HashService.new.reject_keys_that_starts_with!(x, val, count=0)
      #then
      expect(result).to eq(3)
    end
    it 'should count keys that starts with some value in a hash from a hash' do
      #given
      y = {"my_test" => 1, "hash" => {"my_cat" => 3, "something special" => 42}, "my test" => 2, "the chosen one" => 4}
      val = "my"
      #when
      result = HashService.new.reject_keys_that_starts_with!(y, val, count=0)
      #then
      expect(result).to eq(3)
    
    end
  
  end

end

