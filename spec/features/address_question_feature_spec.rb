require 'rails_helper'

feature 'address question' do 

  valid_v_location = 'v_location_label: 8 ter Boulevard du Port 34140 Mèze'
  valid_v_zrr = 'v_zrr: oui'

  before(:each) do
    disable_http_service
    visit new_address_question_path
  end
  after(:each) do
    enable_http_service
  end

  scenario 'By default no address is shown' do 
    expect_search_input_is_empty
  end

  scenario 'User can go back to previous question' do 

    # given
    # when
    find('.js-previous').click
    # then
    expect(current_path).to eq new_grade_question_path
  end

  scenario 'By default no error are shown' do 
    expect_no_error_shown_to_user
  end

  scenario 'If user type an address without use of autocomplete, and go next, an error is shown' do 
    # given
    expect_no_error_shown_to_user
    set_address('11 rue des Lys')
    # when
    go_next
    # then
    expect_current_path_didnt_move
    expect_error_shown_to_user
  end

  scenario 'User is allowed to type no address at all' do 
    # given
    # when
    go_next
    # then
    expect_current_path_changed
  end

  context 'If user type an correct address' do
    scenario 'user go to next step' do
      # given
      set_address("12 Rue des Carmes 45000 Orléans")
      fill_a_nominal_address
      # when
      go_next
      # then
      expect_current_path_changed
    end
  end

  # context 'User has received a link to results' do
  #   before do
  #     asker = create_realistic_asker
  #     visit_aides_for_asker(asker)
  #   end
  #   scenario 'He then go to adress, the address form is hydrated' do
  #     visit new_address_question_path
  #     expect(tiv('input#search'))                     .to eq '45 Rue du Gas 79160 Villiers-en-Plaine'
  #     expect(tiv('input#route'))                      .to eq 'Rue du Gas'
  #     expect(tiv('input#locality'))                   .to eq 'Villiers-en-Plaine'
  #     expect(tiv('input#postal_code'))                .to eq '79160'
  #     expect(tiv('input#country'))                    .to eq 'France'
  #     expect(tiv('input#administrative_area_level_1')).to eq 'Nouvelle-Aquitaine (Poitou-Charentes)'
  #     expect(tiv('input#citycode'))                   .to eq '79351'
  #     expect(tih('input#location_label'))             .to eq '45 Rue du Gas 79160 Villiers-en-Plaine'
  #   end
  # end

  def click_on_modify_address
    click_link('click_link').click
  end

  def expect_no_error_shown_to_user
    expect(page).not_to have_css('label.is-error')
  end
    
  def expect_no_error_shown_to_user
    expect(page).not_to have_css('label.is-error')
  end
    
  def expect_error_shown_to_user
    expect(page).to have_css('label.is-error')
  end
    
  def expect_current_path_didnt_move
    expect(current_path).to eq new_address_question_path
  end

  def expect_current_path_changed
    expect(current_path).not_to eq new_address_question_path
  end

  def expect_search_input_is_empty
    expect(find('input#search', :visible => true).value).to eq('')
  end

  def set_address(address)
    find('input#search').set(address)
  end

  def fill_a_nominal_address
    find('input#street_number').set("12")
    find('input#route').set("Rue des Carmes")
    find('input#locality').set("Orléans")
    find('input#administrative_area_level_1').set("Centre-Val de Loire")
    find('input#postal_code').set("45000")
    find('input#country').set("France")
    find('input#citycode').set("45234")
  end

  def go_next
    find('.js-next').click
  end

  def visit_aides_for_asker(asker)
    visit aides_path + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
  end

  def create_realistic_asker
    return create(:asker, :full_user_input)
  end

end
