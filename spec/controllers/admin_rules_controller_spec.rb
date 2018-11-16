require 'rails_helper'

describe Admin::RulesController do
  describe 'Params' do
    it 'Params returns a ActionController::Parameters' do
      stubbed_params = ActionController::Parameters.new({asker: {v_handicap:"oui"}})
      res = Admin::RulesController.new._asker_params(stubbed_params)
      expect(res.is_a?(ActionController::Parameters)).to eq true
    end
    it 'Params of simulation should include all params of an asker' do
      stubbed_params = ActionController::Parameters.new({asker: {v_handicap:"oui"}})
      res = Admin::RulesController.new._asker_params(stubbed_params).to_h
      # resulting_asker = Asker.new(res)
      empty_asker = Asker.new
      # resulting_asker_keys = resulting_asker.attributes.keys
      empty_asker_keys = empty_asker.attributes.keys
      expect(res).to eq(42)
    end
  end
end
