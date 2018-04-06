require 'rails_helper'
require 'spec_helper'

describe 'Breadcrumb partial' do 

    context 'Display form' do
      selector_under_test = '.c-breadcrumb-current--question'
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
      it 'DONT display results, when /aides without for_id query string param', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_aides_without_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
      it 'DONT display results, when NOT /aides, with for_id query string param', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_not_aides_with_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
    end

    context 'Display details' do
      selector_under_test = '.c-breadcrumb-current--detail'
      it 'Display details, with detail_path with for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_detail_with_forid}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'DONT display details, without detail_path with for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_not_detail_with_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
      it 'DONT display details, with detail_path without for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_detail_without_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
    end

    context 'Display print' do
      selector_under_test = '.c-breadcrumb-print'
      it 'Display print, when aides_path, with for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_aides_with_forid}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'DONT Display print, when aides_path, without for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_aides_without_forid}
        expect(rendered).not_to have_css(selector_under_test)
      end
      it 'Display print, when detail_path, with for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_detail_with_forid}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'Display print, when detail_path, without for_id', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_detail_without_forid}
        expect(rendered).to have_css(selector_under_test)
      end
      it 'DONT Display print, when question_path', type: :view do
        render partial: 'shared/breadcrumb.haml', locals: {context: context_question}
        expect(rendered).not_to have_css(selector_under_test)
      end
    end

    def context_detail_with_forid
      build_req(detail_path('pmsmp'), "any")
    end
    def context_detail_without_forid
      build_req(detail_path('pmsmp'))
    end
    def context_not_detail_with_forid
      build_req(root_path, "any")
    end
    def context_question
      build_req(new_age_question_path)
    end
    def context_not_question
      build_req(root_path)
    end
    def context_aides_with_forid
      build_req(aides_path, "any")
    end
    def context_not_aides_with_forid
      build_req(root_path, "any")
    end
    def context_aides_without_forid
      build_req(aides_path)
    end

    def build_req(path, for_id=nil)
      OpenStruct.new({params: {for_id: for_id}, request: OpenStruct.new({request_method: 'GET', fullpath: path, path: path})})
    end

end
