require 'rails_helper'

feature 'detail of a result page' do 

  context 'No active user' do
    
    before do
      asker = create(:asker, :full_user_input)
      aid = create(:aid, :aid_adult_or_spectacle, name: 'ze_name_for_adult_or_spectacle')
      disable_http_service
      a = TranslateB64AskerService.new.into_b64(asker)
      b = aid.slug
      visit detail_path(b)
    end
    after do
      enable_http_service
    end
    scenario 'Do not display explanation' do
      expect(find_all(".c-detail-why").length).to eq 0
    end
  end

  context 'Active user, cache empty' do
    # See https://makandracards.com/makandra/46189-how-to-rails-cache-for-individual-rspec-tests
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
    result_page = nil
    before do
      if result_page == nil
        # fill database
        asker = create(:asker, :full_user_input)
        aid = create(:aid, :aid_adult_or_spectacle, name: 'ze_name_for_adult_or_spectacle', contract_type: create(:contract_type, :contract_type_1))
        # mock externalities
        disable_http_service
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
        # set system under test
        visit detail_path(aid.slug) + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
        result_page = Nokogiri::HTML(page.html)
      end
    end
    after do
      enable_http_service
      Rails.cache.clear
    end
    scenario 'Display explanation' do
      expect(result_page.css('.c-detail-why').count).to eq 1
    end
    scenario 'Display that adult is eligible' do
      expect(result_page.css('.c-detail-condition.eligible .c-detail-condition-text').text).to eq "adult description"
    end
    scenario 'Display that spectacle is ineligible' do
      expect(result_page.css('.c-detail-condition.ineligible .c-detail-condition-text').text).to eq "spectacle description"
    end
  end

  context 'Active user, cache filled' do
    # See https://makandracards.com/makandra/46189-how-to-rails-cache-for-individual-rspec-tests
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
    result_page = nil
    before do
      if result_page == nil
        # set up data contex
        main_id = "NDMsMyxvLDUsbixwLCxub3RfYXBwbGljYWJsZSxu"
        asker = TranslateB64AskerService.new.from_b64(main_id)
        aid = create(:aid, :aid_adult_or_spectacle, name: 'ze_name_for_adult_or_spectacle')
        # mock externalities
        disable_http_service
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
        Rails.cache.write(main_id, {asker: asker.attributes})
        # set system under test
        visit detail_path(aid.slug) + '?for_id=' + main_id
        result_page = Nokogiri::HTML(page.html)
      end
    end
    after do
      enable_http_service
      Rails.cache.clear
    end
    scenario 'Display explanation' do
      expect(result_page.css('.c-detail-why').count).to eq 1
    end
    scenario 'Display that adult is eligible' do
      expect(result_page.css('.c-detail-condition.eligible .c-detail-condition-text').text).to eq "adult description"
    end
    scenario 'Display that spectacle is ineligible' do
      expect(result_page.css('.c-detail-condition.ineligible .c-detail-condition-text').text).to eq "spectacle description"
    end
  end


end
