require 'rails_helper'
require 'spec_helper'

RSpec.shared_examples "a contract type page" do |details|
  context "Nominal" do
    sut = nil
    before do
      sut = configure_before_block(details)
    end
    if (details[:exp_com] != nil)
      it "Should show #{details[:exp_com]} main component" do
        expect(sut).to have_css('.c-type-explanation', count: details[:exp_com])
      end
    end
    if (details[:exp_msg] != nil)
      it "Should include \"#{details[:exp_msg]}\" in the message" do
        expect(sut).to have_css('.c-type-explanation', text: details[:exp_msg])
      end
    end
    if (details[:exp_aid_msg] != nil)
      it "Should include \"#{details[:exp_aid_msg]}\"" do
        expect(sut).to have_css('.aid-nb-txt', text: details[:exp_aid_msg])
      end
    end
  end
end

RSpec.describe "amob"                  do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'amob',                         exp_com: 1, exp_msg: 'mobilité',      exp_aid_msg: '2 aides'} end
RSpec.describe "projet-pro"            do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'projet-pro',                   exp_com: 1, exp_msg: 'professionnel', exp_aid_msg: '2 aides'} end
RSpec.describe "alternance"            do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'alternance',                   exp_com: 1, exp_msg: 'alternance',    exp_aid_msg: '2 aides'} end
RSpec.describe "creation d'entreprise" do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'creation-reprise-entreprise',  exp_com: 1, exp_msg: 'entreprise',    exp_aid_msg: '2 aides'} end

RSpec.describe "any business_id"       do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'any',       exp_com: 0} end
RSpec.describe "any_other business_id" do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: 'any_other', exp_com: 0} end
RSpec.describe "nil business_id"       do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: nil,         exp_com: 0} end
RSpec.describe "wrong business_id"     do it_should_behave_like "a contract type page", {number_of_aids:2, business_id: Date.new,    exp_com: 0} end

RSpec.describe "amob no aid_number"    do it_should_behave_like "a contract type page", {business_id: 'amob', exp_com: 0} end
RSpec.describe "amob nil aid_number"   do it_should_behave_like "a contract type page", {number_of_aids:nil,      business_id: 'amob',  exp_com: 0} end
RSpec.describe "amob 0 aid_number"     do it_should_behave_like "a contract type page", {number_of_aids:0,        business_id: 'amob',  exp_com: 0} end
RSpec.describe "amob wrong aid_number" do it_should_behave_like "a contract type page", {number_of_aids:Date.new, business_id: 'amob',  exp_com: 0} end
RSpec.describe "amob 0 aid_number"     do it_should_behave_like "a contract type page", {number_of_aids:0,        business_id: 'amob',  exp_com: 0} end
RSpec.describe "amob 1 aid_number"     do it_should_behave_like "a contract type page", {number_of_aids:1,        business_id: 'amob',  exp_com: 1, exp_msg: 'mobilité', exp_aid_msg: '1 aide'} end
RSpec.describe "amob 2 aid_number"     do it_should_behave_like "a contract type page", {number_of_aids:2,        business_id: 'amob',  exp_com: 1, exp_msg: 'mobilité', exp_aid_msg: '2 aides'} end
RSpec.describe "amob 5 aid_number"     do it_should_behave_like "a contract type page", {number_of_aids:5,        business_id: 'amob',  exp_com: 1, exp_msg: 'mobilité', exp_aid_msg: '5 aides'} end


def configure_before_block(details)
  locals_hash = {}
  if (details.key?(:number_of_aids))
    locals_hash[:number_of_aids] = details[:number_of_aids]
  end
  if (details.key?(:business_id))
    locals_hash[:business_id] = details[:business_id]
  end
  render partial: 'shared/type_explanation', locals: locals_hash
  rendered
end


