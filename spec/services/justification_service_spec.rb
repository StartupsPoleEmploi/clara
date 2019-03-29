require 'rails_helper'

describe JustificationService do

  # describe '.root_rules' do
  #   it 'should return all rules of the root rule when it is a complex rule' do

  #     # given
  #     create(:aid, :aid_adult_and_spectacle)
  #     the_service = JustificationService.new(Aid.last)
  #     all_rules = Rule.all
  #     spectacle_rule = Rule.find{|e| e.name.include?('r_composed_be_a_spectacle0')}
  #     adult_rule = Rule.find{|e| e.name.include?('r_composed_be_an_adult0')}
  #     expect(spectacle_rule.id).not_to be nil
  #     expect(adult_rule.id).not_to be nil

  #     # when
  #     result = the_service.root_rules

  #     # then
  #     expect(result.length).to eq(2)
  #     expect(result.include?(spectacle_rule)).to eq(true)
  #     expect(result.include?(adult_rule)).to eq(true)
  #   end

  #   it 'should return the root rule inside an array when it is a simple rule' do
  #     # given
  #     create(:aid, :aid_spectacle)
  #     the_service = JustificationService.new(Aid.last)
  #     the_rule = Rule.last

  #     # when
  #     result = the_service.root_rules

  #     # then
  #     expect(result.length).to eq(1)
  #     expect(result.include?(the_rule)).to eq(true)
  #   end

  #   it 'should return an empty array by default' do
  #     # given
  #     the_service = JustificationService.new(nil)

  #     # when
  #     result = the_service.root_rules

  #     # then
  #     expect(result).to eq []
  #   end

  # end

  # describe '.root_condition' do
  #   it 'should return an empty string by default' do
  #     # given
  #     the_service = JustificationService.new(nil)

  #     # when
  #     result = the_service.root_condition

  #     # then
  #     expect(result).to eq ''
  #   end
  #   it 'should return "and" if the root condition is an AND rule' do
  #     # given
  #     create(:aid, :aid_adult_and_spectacle)
  #     the_service = JustificationService.new(Aid.last)
  #     # when
  #     result = the_service.root_condition
  #     # then
  #     expect(result).to eq('and')
  #   end
  #   it 'should return "or" if the root condition is a OR rule' do
  #     # given
  #     create(:aid, :aid_adult_or_spectacle)
  #     the_service = JustificationService.new(Aid.last)
  #     # when
  #     result = the_service.root_condition
  #     # then
  #     expect(result).to eq('or')     
  #   end
  #   it 'should return "one" if the root condition is a simple rule' do
  #     # given
  #     create(:aid, :aid_spectacle)
  #     the_service = JustificationService.new(Aid.last)
  #     # when
  #     result = the_service.root_condition
  #     # then
  #     expect(result).to eq('one')     
  #   end
  # end

end
