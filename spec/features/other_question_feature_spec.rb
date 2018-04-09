require 'rails_helper'

RSpec.feature 'other question' do 


  class OtherCheckbox 

    attr_reader :id, :element 

    def initialize(id, find_method)
      @id = id
      @element = find_method.call('input#' + id, visible: :false)
    end

  end

  ocbSpectacle = nil
  ocbHandicap = nil
  ocbNone = nil
  all_value_inputs = nil
  all_inputs = nil
  Ocb = OtherCheckbox

  before(:each) do
    visit new_other_question_path

    ocbSpectacle = Ocb.new('val_spectacle', method(:find))
    ocbHandicap = Ocb.new('val_handicap', method(:find))
    ocbNone = Ocb.new('none', method(:find))
    all_value_inputs = [ocbSpectacle, ocbDetenu, ocbPi, ocbHandicap]
    all_inputs = all_value_inputs + [ocbNone]
  end

  scenario 'By default checkboxes inputs are empty, session hash is not impacted' do 

    # given
    # when

    # then
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).not_to include 'v_spectacle: oui'
    expect(asker_obj).not_to include 'v_handicap: oui'
  end

  scenario 'If user validates without any checked checkboxes, user stay on page with an error message' do 

    # given
    expect_all_unchecked(all_inputs.map(&:element))

    # when
    find('.js-next').click
    
    # then
    expect(current_path).to eq new_other_question_path
    expect(page).to have_css('label.is-error')
    expect(page).to have_css('fieldset.is-error')
  end

  scenario 'When checking all VALUE checkbox, asker object is saved into session, user goes to next path' do 

    # given
    expect_all_unchecked(all_value_inputs.map(&:element))

    # when
    all_value_inputs.map(&:id).each do |id_situation|
      page.check(id_situation)
    end
    expect_all_checked(all_value_inputs.map(&:element))
    find('.js-next').click

    # then
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).to include '"v_spectacle":"oui"'
    expect(asker_obj).to include '"v_handicap":"oui"'

    expect(current_path).not_to eq new_other_question_path
  end

  scenario 'When a value checkbox is saved, this checkbox is restored if user comes back to the page' do 

    # given
    expect_all_unchecked(all_inputs.map(&:element))
    page.check(ocbDetenu.id)
    page.check(ocbPi.id)

    # when
    find('.js-next').click
    expect(current_path).not_to eq new_address_question_path
    visit new_other_question_path
    
    # then
    expect_all_unchecked([ocbSpectacle, ocbHandicap, ocbNone].map(&:element))
    expect_all_checked([ocbDetenu, ocbPi].map(&:element))
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).not_to include '"v_spectacle":"oui"'
    expect(asker_obj).not_to include '"v_handicap":"oui"'
  end
  
end
