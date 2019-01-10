require 'rails_helper'

describe Admin::RulesController do
  describe 'Params' do
    it 'Params returns a ActionController::Parameters' do
      stubbed_params = ActionController::Parameters.new({asker: {v_handicap:"oui"}})
      res = Admin::RulesController.new._asker_params(stubbed_params)
      expect(res.is_a?(ActionController::Parameters)).to eq true
    end
    it 'Params of simulation should fullfil all hash values' do
      full_asker = RandomAskerService.new.full.attributes
      stubbed_params = ActionController::Parameters.new({asker: full_asker})
      params_as_hash = Admin::RulesController.new._asker_params(stubbed_params).to_h
      expect(params_as_hash.values.any?(&:blank?)).to eq false
      
    end
    it 'Params of simulation should have all keys that a asker can have' do
      #given
      full_asker = RandomAskerService.new.full.attributes
      stubbed_params = ActionController::Parameters.new({asker: full_asker})
      #when
      params_as_hash = Admin::RulesController.new._asker_params(stubbed_params).to_h
      #then
      expected_keys = Asker.new.attributes.keys
      actual_keys = params_as_hash.keys

      # Check first that both array are non-empty and full of Strings
      expect(expected_keys.is_a?(Array)).to eq(true)
      expect(actual_keys.is_a?(Array)).to eq(true)
      expect(expected_keys.size > 0).to eq(true)
      expect(actual_keys.size > 0).to eq(true)
      expect(expected_keys.all? { |e| e.is_a?(String)  }).to eq(true)
      expect(actual_keys.all? { |e| e.is_a?(String)  }).to eq(true)

      # Actual test happens here : both arrays should have the same elements,
      # Otherwise the failing test will show the keys that are missing.
      keys_difference = expected_keys - actual_keys
      expect(keys_difference).to eq []

    end
  end
end
