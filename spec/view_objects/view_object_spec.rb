require 'rails_helper'

describe ViewObject do
    
  sut = ViewObject.new(nil)
  
  describe '.array_of_hash_for' do
    it 'Return [] for new Date' do
      expect(sut.array_of_hash_for(Date.new)).to eq []   
    end
    it 'Return [] for []' do
      expect(sut.array_of_hash_for([])).to eq []   
    end
    it 'Return [] for [1,2,3]' do
      expect(sut.array_of_hash_for([1,2,3])).to eq []   
    end
    it 'Return [{}] for [{}]' do
      expect(sut.array_of_hash_for([{}])).to eq [{}]   
    end
    it 'Return [{a: 1}] for [{a: 1}]' do
      expect(sut.array_of_hash_for([{a: 1}])).to eq [{a: 1}]   
    end
    it 'Return [{a: 1}] for [{"a" => 1}]' do
      expect(sut.array_of_hash_for([{"a" => 1}])).to eq [{a: 1}]   
    end
    it 'Return [{a: 1}, {b: 2}] for [{"a" => 1}, {b: 2}]' do
      expect(sut.array_of_hash_for([{"a" => 1}, {b: 2}])).to eq [{a: 1}, {b: 2}]   
    end
  end

  describe '.integer_for' do
    it 'Return 0 for new Date' do
      expect(sut.integer_for(Date.new)).to eq 0 
    end
    it 'Return 0 for "57"' do
      expect(sut.integer_for("57")).to eq 0   
    end
    it 'Return 0 for nil' do
      expect(sut.integer_for(nil)).to eq 0
    end
    it 'Return 0 for 0' do
      expect(sut.integer_for(0)).to eq 0  
    end
    it 'Return 1 for 1' do
      expect(sut.integer_for(1)).to eq 1   
    end
    it 'Return 2 for 2' do
      expect(sut.integer_for(2)).to eq 2   
    end
    it 'Return 57 for 57' do
      expect(sut.integer_for(57)).to eq 57   
    end
  end

  describe '.hash_for' do
    it 'Return {} for new Date' do
      expect(sut.hash_for(Date.new)).to eq({})
    end
    it 'Return {} for nil' do
      expect(sut.hash_for(nil)).to eq({})
    end
    it 'Return {} for {}' do
      expect(sut.hash_for({})).to eq({})
    end
    it 'Return {a: 1} for {a: 1}' do
      expect(sut.hash_for({a: 1})).to eq({a: 1})
    end
    it 'Return {a: 1} for {"a" => 1}' do
      expect(sut.hash_for({"a" => 1})).to eq({a: 1})
    end
    it 'Return {a: 1, b: 2} for {"a" => 1, b: 2}' do
      expect(sut.hash_for({"a" => 1, b: 2})).to eq({a: 1, b: 2})
    end
  end

  describe '.boolean_for' do
    it 'Return false for new Date' do
      expect(sut.boolean_for(Date.new)).to eq(false)
    end
    it 'Return false for nil' do
      expect(sut.boolean_for(nil)).to eq(false)
    end
    it 'Return false for "a_String"' do
      expect(sut.boolean_for("a_String")).to eq(false)
    end
    it 'Return false for false' do
      expect(sut.boolean_for(false)).to eq(false)
    end
    it 'Return true for true' do
      expect(sut.boolean_for(true)).to eq(true)
    end
  end

  describe '.array_for' do
    it 'Return [] for new Date' do
      expect(sut.array_for(Date.new)).to eq []   
    end
    it 'Return [] for nil' do
      expect(sut.array_for(nil)).to eq []   
    end
    it 'Return [] for []' do
      expect(sut.array_for([])).to eq []   
    end
    it 'Return [0] for [0]' do
      expect(sut.array_for([0])).to eq [0]   
    end
    it 'Return [1,2,3] for [1,2,3]' do
      expect(sut.array_for([1,2,3])).to eq [1,2,3]   
    end
  end

  describe '.string_for' do
    it 'Return "" for new Date' do
      expect(sut.string_for(Date.new)).to eq ""   
    end
    it 'Return "" for nil' do
      expect(sut.string_for(nil)).to eq ""   
    end
    it 'Return "" for ""' do
      expect(sut.string_for("")).to eq ""   
    end
    it 'Return "a" for "a"' do
      expect(sut.string_for("a")).to eq "a"   
    end
    it 'Return "foo bar" for "foo bar"' do
      expect(sut.string_for("foo bar")).to eq "foo bar"   
    end
  end

end
