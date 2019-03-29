require 'rails_helper'

feature 'Sitemap' do 

  # scenario 'Main page of sitemap has url of sub-sitemap "aides"' do 
  #   visit main_sitemap_path
  #   expect(page).to have_content("http://www.example.com/aides-sitemap.xml")
  # end

  # scenario 'Main page of sitemap has url of sub-sitemap "types"' do 
  #   visit main_sitemap_path
  #   expect(page).to have_content("http://www.example.com/types-aides-sitemap.xml")
  # end

  # scenario 'Sub sitemap "aides" has a link to all aides' do 
  #   visit aides_sitemap_path
  #   expect(page).to have_content("http://www.example.com/aides")
  # end

  # scenario 'Sub sitemap "aides" has link to the detail of each aid' do 
  #   visit aides_sitemap_path
  #   expect(page).not_to have_content("http://www.example.com/aides/detail/ze_aide_1")
  #   expect(page).not_to have_content("http://www.example.com/aides/detail/ze_aide_2")
  #   create(:aid, :aid_spectacle, name: 'ze_aide_1')
  #   create(:aid, :aid_agepi, name: 'ze_aide_2')
  #   visit aides_sitemap_path
  #   expect(page).to have_content("http://www.example.com/aides/detail/ze_aide_1")
  #   expect(page).to have_content("http://www.example.com/aides/detail/ze_aide_2")
  # end
  
  # scenario 'Sub sitemap "types" has link to each of the types' do 
  #   visit types_sitemap_path
  #   expect(page).not_to have_content("http://www.example.com/aides/type/ze_contract_type")
  #   expect(page).not_to have_content("http://www.example.com/aides/type/ze_contract_type2")
  #   create(:contract_type, :contract_type_1)
  #   create(:contract_type, :contract_type_2)
  #   visit types_sitemap_path
  #   expect(page).to have_content("http://www.example.com/aides/type/n1")
  #   expect(page).to have_content("http://www.example.com/aides/type/n2")
  # end
  
end
