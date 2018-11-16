require 'rails_helper'

describe RandomAskerService do

  describe '.go' do
    it 'Should return an Asker' do
      res = RandomAskerService.new.go      
      expect(res.is_a?(Asker)).to eq true
    end
    it 'Should return all fields of an asker as non-empty' do
      asker = RandomAskerService.new.go      
      asker_attributes_values = asker.attributes.values
      no_attribute_is_left_empty = asker_attributes_values.all? { |e| !e.blank? }
      expect(no_attribute_is_left_empty).to eq true
    end
  end
end
