require 'rails_helper'

describe CalculateRuleSimulated do

  describe '.call' do
      it 'should return ok when ...'  do
      #given 
      res = ""
      rule = ""
      allow_any_instance_of(Rule).to receive(:tested).and_return("ok")
      #when
      res = CalculateRuleSimulated.new.call(rule)
      #then
      expect(res).to eq("ok")
    end
  end

end
