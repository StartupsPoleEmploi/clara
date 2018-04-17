require 'rails_helper'
require 'spec_helper'
require 'nokogiri'

describe 'shared/_detail_why' do 

  it 'Should not render at all without args' do
    render 
    page = Nokogiri::HTML(rendered)
    expect(page.root).to eq(nil)
  end
  
  it 'Should render in correct namespace with nominal_args' do
    render partial: 'shared/detail_why', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.root).not_to eq(nil)
    expect(rendered).to have_css('.c-detail-why')
  end
  
  it 'Should render appropriate message if ability is eligible' do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    render partial: 'shared/detail_why', locals: local_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-why--eligible').text.strip).to eq('Vous êtes éligible')
  end
  
  it 'Should render appropriate message if ability is ineligible' do
    local_args = nominal_args
    local_args[:ability] = "ineligible"
    render partial: 'shared/detail_why', locals: local_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-why--ineligible').text.strip).to eq('Vous n\'êtes pas éligible')
  end
  
  it 'Should render appropriate message if ability is uncertain' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-why--uncertain').text.strip).to eq('Vous êtes peut-être éligible')
  end
  
  it 'Should render appropriate message for AND rule' do
    local_args = nominal_args
    local_args[:root_condition] = "and"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-haveto--and')
  end
  
  it 'Should render appropriate message for OR rule' do
    local_args = nominal_args
    local_args[:root_condition] = "or"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-haveto--or')
  end
  
  it 'Should render appropriate message for ONE rule' do
    local_args = nominal_args
    local_args[:root_condition] = "one"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-haveto--one')
  end
  
  it 'Should render appropriate addendum when ALL_CONDITIONS are met' do
    local_args = nominal_args
    local_args[:root_rules].each {|rule| rule[:status] = "eligible"}
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--all')
  end
  
  it 'Should render appropriate addendum when NO_CONDITION are met' do
    local_args = nominal_args
    local_args[:root_rules].each {|rule| rule[:status] = "ineligible"}
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--none')
  end

  it 'Should render appropriate addendum when the ability is UNCERTAIN' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain')
  end
  
  it 'Should render appropriate addendum when the ability is UNCERTAIN' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain')
  end
  
  it 'Should render eligible-single-amongst if eligibility is ELIGIBLE and there are many rules, but only one ELIGIBLE rule' do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    local_args[:root_rules][0][:status] = "ineligible"
    local_args[:root_rules][1][:status] = "eligible"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--eligible-single-amongst')
  end
  
  it 'Should render eligible-single-plural if eligibility is ELIGIBLE and there are many rules, and many ELIGIBLE rules (but not all)' do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    local_args[:root_rules][0][:status] = "eligible"
    local_args[:root_rules][1][:status] = "eligible"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--eligible-single-plural')
  end
  
  it 'Should render uncertain-single-alone if eligibility is UNCERTAIN and there is only one rule, an UNCERTAIN rule' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules].pop
    local_args[:root_rules].pop
    local_args[:root_rules][0][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain-single-alone')
  end
  
  it 'Should render uncertain-single-amongst if eligibility is UNCERTAIN and there is only one UNCERTAIN rule amongst MANY' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules][0][:status] = "ineligible"
    local_args[:root_rules][1][:status] = "eligible"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain-single-amongst')
  end
  
  it 'Should render uncertain-plural if eligibility is UNCERTAIN and there are many UNCERTAIN rules' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules][0][:status] = "ineligible"
    local_args[:root_rules][1][:status] = "uncertain"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain-plural')
  end
  
  it 'Should render uncertain-plural-all if eligibility is UNCERTAIN and there are as many UNCERTAIN rules as total number of rules' do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules][0][:status] = "uncertain"
    local_args[:root_rules][1][:status] = "uncertain"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-addendum--uncertain-plural-all')
  end
  
  it 'Should render eligible rules on top if the ability is ELIGIBLE' do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    render partial: 'shared/detail_why', locals: local_args
    page = Nokogiri::HTML(rendered)
    all_status = page.css('.c-detail-condition')[0]["data-status"]
    expect(all_status).to eq("eligible")
  end
  
  it 'Should render ineligible rules on top if the ability is INELIGIBLE' do
    local_args = nominal_args
    local_args[:ability] = "ineligible"
    local_args[:root_rules][0][:status] = "eligible"
    local_args[:root_rules][1][:status] = "ineligible"
    local_args[:root_rules][2][:status] = "uncertain"
    render partial: 'shared/detail_why', locals: local_args
    page = Nokogiri::HTML(rendered)
    all_status = page.css('.c-detail-condition')[0]["data-status"]
    expect(all_status).to eq("ineligible")
  end
  
  it 'Should render even if ability is wrong' do
    local_args = nominal_args
    local_args[:ability] = "azerty"
    render partial: 'shared/detail_why', locals: local_args
    expect(rendered).to have_css('.c-detail-why')
  end
  
  def nominal_args
    {
      :ability => "eligible", 
      :root_condition => "or", 
      :root_rules => [
                      {:status => "ineligible",
                        :name => "r_age_sup_26_et_inscrit",
                        :description => "Avoir plus de 26 ans et être inscrit/e à Pôle emploi"
                      }, 
                      {:status => "eligible",
                        :name => "r_ass_ou_rsa_ou_aah",
                        :description => "Etre indemnisé/e au titre du RSA, de l'ASS ou de l'AAH"
                      }, 
                      {:status => "uncertain",
                        :name => "r_age_sup_16_et_age_inf_26",
                        :description => "Avoir entre 16 et 26 ans"
                      }]
    }
  end


end
