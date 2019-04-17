# require 'rails_helper'
# require 'spec_helper'

# RSpec.shared_examples "a contract type page" do |details|
#   context "Nominal" do
#     sut = nil
#     before do
#       sut = configure_before_block(details)
#     end
#     if (details[:exp_com] != nil)
#       it "Should show #{details[:exp_com]} main component" do
#         expect(sut).to have_css('.c-type-explanation', count: details[:exp_com])
#       end
#     end
#     if (details[:exp_msg] != nil)
#       it "Should include \"#{details[:exp_msg]}\" in the message" do
#         expect(sut).to have_css('.c-type-explanation', text: details[:exp_msg])
#       end
#     end
#     if (details[:exp_aid_msg] != nil)
#       it "Should include \"#{details[:exp_aid_msg]}\"" do
#         expect(sut).to have_css('.aid-nb-txt', text: details[:exp_aid_msg])
#       end
#     end
#   end
# end

# RSpec.describe "aide-a-la-creation-ou-reprise-d-entreprise" do
#  it_should_behave_like "a contract type page", 
#  {number_of_aids:2, 
#   slug: 'aide-a-la-creation-ou-reprise-d-entreprise',                   
#   exp_com: 1, 
#   exp_msg: 'entreprise', 
#   exp_aid_msg: '2 aides'} 
# end

# RSpec.describe "aide-a-la-mobilite" do 
#   it_should_behave_like "a contract type page", 
#   {number_of_aids:2, 
#     slug: 'aide-a-la-mobilite',                         
#     exp_com: 1, 
#     exp_msg: 'mobilité',      
#     exp_aid_msg: '2 aides'} 
# end

# RSpec.describe "contrat-en-alternance" do 
#   it_should_behave_like "a contract type page", 
#   {number_of_aids:2, 
#     slug: 'contrat-en-alternance',                         
#     exp_com: 1, 
#     exp_msg: 'alternance',      
#     exp_aid_msg: '2 aides'} 
# end

# RSpec.describe "aide-a-la-definition-du-projet-professionnel" do
#  it_should_behave_like "a contract type page", 
#  {number_of_aids:2, 
#   slug: 'aide-a-la-definition-du-projet-professionnel',                   
#   exp_com: 1, 
#   exp_msg: 'professionnel', 
#   exp_aid_msg: '2 aides'} 
# end

# RSpec.describe "aide-a-la-mobilite without aids" do 
#   it_should_behave_like "a contract type page", 
#   {number_of_aids:nil, 
#     slug: 'aide-a-la-mobilite',                         
#     exp_com: 0} 
# end

# RSpec.describe "aide-a-la-mobilite with 5 aids" do 
#   it_should_behave_like "a contract type page", 
#   {number_of_aids:5, 
#     slug: 'aide-a-la-mobilite',                         
#     exp_com: 1, 
#     exp_msg: 'mobilité',      
#     exp_aid_msg: '5 aides'} 
# end


 
# def configure_before_block(details)
#   locals_hash = {}
#   if (details.key?(:number_of_aids))
#     locals_hash[:number_of_aids] = details[:number_of_aids]
#   end
#   if (details.key?(:slug))
#     locals_hash[:slug] = details[:slug]
#   end
#   render partial: 'shared/type_explanation', locals: locals_hash
#   rendered
# end


