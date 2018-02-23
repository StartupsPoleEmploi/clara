require 'rails_helper'
require 'spec_helper'

describe 'Breadcrumb partial' do 

    # it 'Can print and mail to product owner', type: :view do
    #   render partial: 'shared/breadcrumb.haml', locals: { where: 'finals' }
    #   expect(rendered).to have_css('.c-breadcrumb')
    # end

    context 'Display form' do
      selector_under_test = 'c-breadcrumb-current--question'
      it 'Display form, when a question is displayed', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_question}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'DONT Display form, when a question is NOT displayed', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_not_question}
        expect(rendered).not_to have_css(selector_under_test)
      end
    end

    context 'Display results' do
      selector_under_test = '.c-breadcrumb-current--results'
      it 'Display results, when /aides?for_id=', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_aides_with_forid}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'Do not display results, when /aides without for_id query string param', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_aides_without_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
      it 'Do not display results, when NOT /aides, with for_id query string param', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_not_aides_with_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
    end

    # it 'Display breadcrumb for question when a question is displayed' do
    #   all_question_path = RoutesList.asked_questions.values.map {|v| v[0...-10]}
    #   all_question_path.each do |question_path|
    #     visit question_path
    #     expect(page).to have_css('.c-breadcrumb-current--question')
    #   end
    # end

    # it 'Display breadcrumb for results when results are displayed' do
    #   name_of_aid = 'harki-test'
    #   asker = Asker.new(v_harki: 'oui')
    #   create(:aid, :aid_harki, name: name_of_aid)

    #   base64_str = ConvertAskerInBase64Service.new.into_base64(asker)
    #   visit(aides_path + '?for_id=' + base64_str)
    #   expect(page).to have_css('.c-breadcrumb-current--results')
    #   expect(page).to have_css('.c-breadcrumb .js-printer')
    # end

    # it 'Display breadcrumb for detail when detail is displayed', focus: true do
    #   name_of_aid = 'harki-test'
    #   asker = Asker.new(v_harki: 'oui')
    #   create(:aid, :aid_harki, name: name_of_aid)

    #   base64_str = ConvertAskerInBase64Service.new.into_base64(asker)
    #   visit final_detail_path (base64_str)
    #   expect(page).to have_css('.c-breadcrumb-current--detail')
    #   expect(page).to have_css('.c-breadcrumb .js-printer')
    # end

    def context_not_question
      OpenStruct.new({request: OpenStruct.new({path: root_path})})
    end
    def context_question
      OpenStruct.new({request: OpenStruct.new({path: new_age_question_path})})
    end
    def context_aides_with_forid
      OpenStruct.new({params: {for_id: "any"}, request: OpenStruct.new({path: aides_path})})
    end
    def context_not_aides_with_forid
      OpenStruct.new({params: {for_id: "any"}, request: OpenStruct.new({path: root_path})})
    end
    def context_aides_without_forid
      OpenStruct.new({params: {}, request: OpenStruct.new({path: aides_path})})
    end

end
