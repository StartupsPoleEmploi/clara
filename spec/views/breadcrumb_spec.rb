require 'rails_helper'
require 'spec_helper'

feature 'Breadcrumb partial' do 

    scenario 'Can print and mail to product owner', type: :view do
      render partial: 'shared/breadcrumb.haml', locals: { where: 'finals' }
      expect(rendered).to have_css('.c-breadcrumb')
    end

    scenario 'Display breadcrumb for question when a question is displayed' do
      all_question_path = RoutesList.get_questions.values.map {|v| v[0...-10]}
      all_question_path.each do |question_path|
        visit question_path
        expect(page).to have_css('.c-breadcrumb-current--question')
      end
    end

    scenario 'Display breadcrumb for results when results are displayed' do
      name_of_aid = 'harki-test'
      asker = Asker.new(v_harki: 'oui')
      create(:aid, :aid_harki, name: name_of_aid)

      base64_str = ConvertAskerInBase64Service.new.into_base64(asker)
      visit(aides_path + '?for_id=' + base64_str)
      expect(page).to have_css('.c-breadcrumb-current--results')
      expect(page).to have_css('.c-breadcrumb .js-printer')
    end

    # scenario 'Display breadcrumb for detail when detail is displayed', focus: true do
    #   name_of_aid = 'harki-test'
    #   asker = Asker.new(v_harki: 'oui')
    #   create(:aid, :aid_harki, name: name_of_aid)

    #   base64_str = ConvertAskerInBase64Service.new.into_base64(asker)
    #   visit final_detail_path (base64_str)
    #   expect(page).to have_css('.c-breadcrumb-current--detail')
    #   expect(page).to have_css('.c-breadcrumb .js-printer')
    # end

end
