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
      
      # all_asker_keys = Asker.new.attributes.keys
      # ordered_params_as_hash = params_as_hash.sort
      # ordered_all_asker_keys = all_asker_keys.sort
      # expect(ordered_params_as_hash).not_to eq nil
      # expect(ordered_all_asker_keys).not_to eq nil
    end
    it 'Params of simulation should have all keys that a asker can have' do
      #given
      full_asker = RandomAskerService.new.full.attributes
      stubbed_params = ActionController::Parameters.new({asker: full_asker})
      #when
      params_as_hash = Admin::RulesController.new._asker_params(stubbed_params).to_h
      #then
      expected_keys = Asker.new.attributes.keys.sort
      actual_keys = params_as_hash.keys.sort
      expect(expected_keys.is_a?(Array)).to eq(true)
      expect(actual_keys.is_a?(Array)).to eq(true)
      expect(expected_keys.size > 0).to eq(true)
      expect(actual_keys.size > 0).to eq(true)
      expect(expected_keys.all? { |e| e.is_a?(String)  }).to eq(true)
      expect(actual_keys.all? { |e| e.is_a?(String)  }).to eq(true)

      keys_intersection = expected_keys - actual_keys
      expect(keys_intersection).to eq []

      p '- - - - - - - - - - - - - - params_as_hash- - - - - - - - - - - - - - - -' 
      # pp params_as_hash.keys
      # pp params_as_hash.keys.sort
      # pp expected_keys
      # pp actual_keys
      p ''

    end
  end
end
