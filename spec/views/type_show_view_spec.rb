require 'rails_helper'
require 'spec_helper'

# describe 'type/show' do 

#   shared_examples "a show type view" do |details|
#     sut = nil
#     before do
#       sut = configure_before_block(details)
#     end
#     it "Should show contract type title \"#{details[:exp_title]}\"" do
#       expect(sut).to have_css('.c-detail-title-inside', text: details[:exp_title])
#     end
#     it "Should show #{details[:exp_result_line]} result line" do
#       expect(sut).to have_css('.c-result-line', count: "#{details[:exp_result_line]}")
#     end
#     it "Should show .c-detail-void" do
#       expect(sut).to have_css('.c-detail-void', count: 1)
#     end
#     it "Should show #{details[:exp_css]}" do
#       expect(sut).to have_css("#{details[:exp_css]}", count: 1)
#     end
#   end

#   describe "Everything correct" do it_should_behave_like "a show type view", {contract_type: {description: 'any', business_id: 'biz-id'}, aids: [1,2], exp_title: 'any', exp_result_line: 1, exp_css: '.c-detail-title--biz-id'} end
#   describe "No aid given" do it_should_behave_like "a show type view", {contract_type: {description: 'any', business_id: 'biz-id'}, aids: [], exp_title: 'any', exp_result_line: 0, exp_css: '.c-detail-title--biz-id'} end
#   describe "Missing inputs" do it_should_behave_like "a show type view", {exp_title: '', exp_result_line: 0, exp_css: '.c-detail-title--'} end

#   def configure_before_block(details)
#     locals_hash = {}
#     if details.has_key?(:contract_type)
#       locals_hash[:contract_type] = details[:contract_type]
#     end
#     if details.has_key?(:aids)
#       locals_hash[:aids] = details[:aids]
#     end
#     assign(:loaded, locals_hash)
#     render
#     rendered
#   end


# end
