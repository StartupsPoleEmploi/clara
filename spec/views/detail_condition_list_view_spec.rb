require 'rails_helper'
require 'spec_helper'
require 'nokogiri'

describe 'shared/_detail_condition_list' do 

  it 'Should not render at all without args' do
    render 
    page = Nokogiri::HTML(rendered)
    expect(page.root).to eq(nil)
  end
  
  it 'Should render in correct namespace with nominal_args' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.root).not_to eq(nil)
    expect(rendered).to have_css('.c-detail-conditions-list')
  end
  
  it 'Should render as much lines as conditions' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition').size).to eq(3)
  end
  
  it 'An UNCERTAIN condition has the svg with QUESTION mark' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition.uncertain svg')[0]['class']).to include('question')
  end
  
  it 'a SEPARATOR appears if there is one UNCERTAIN condition amongst many' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    expect(rendered).to have_css('.r_age_sup_16_et_age_inf_26 .uncertain .c-detail-condition__raw.c-detail-condition__separator')
  end
  
  it 'a SEPARATOR do NOT APPEAR if there are NOT UNCERTAIN condition' do
    local_args = nominal_args
    local_args[:conditions][0][:status] = "ineligible"
    local_args[:conditions][1][:status] = "eligible"
    local_args[:conditions][2][:status] = "ineligible"
    render partial: 'shared/detail_condition_list', locals: local_args
    expect(rendered).not_to have_css('.c-detail-condition__separator')
  end
  
  it 'a SEPARATOR do NOT APPEAR if there is a SINGLE UNCERTAIN condition' do
    local_args = nominal_args
    local_args[:conditions].pop
    local_args[:conditions].pop
    local_args[:conditions][0][:status] = "uncertain"
    render partial: 'shared/detail_condition_list', locals: local_args
    expect(rendered).not_to have_css('.c-detail-condition__separator')
  end
  
  it 'a SEPARATOR do NOT APPEAR if there is are ONLY uncertain condition' do
    local_args = nominal_args
    local_args[:conditions][0][:status] = "uncertain"
    local_args[:conditions][1][:status] = "uncertain"
    local_args[:conditions][2][:status] = "uncertain"
    render partial: 'shared/detail_condition_list', locals: local_args
    expect(rendered).not_to have_css('.c-detail-condition__separator')
  end
  
  it 'a SEPARATOR appears IN LAST POSITION ONLY if there is many UNCERTAIN conditions amongst VARIOUS conditions' do
    local_args = nominal_args
    local_args[:conditions][0][:status] = "uncertain"
    local_args[:conditions][1][:status] = "uncertain"
    local_args[:conditions][2][:status] = "ineligible"
    render partial: 'shared/detail_condition_list', locals: local_args
    expect(rendered).to have_css('.r_age_sup_26_et_inscrit .uncertain .c-detail-condition__raw')
    expect(rendered).not_to have_css('.r_age_sup_26_et_inscrit .uncertain .c-detail-condition__raw.c-detail-condition__separator')
    expect(rendered).to have_css('.r_ass_ou_rsa_ou_aah .uncertain .c-detail-condition__raw')
    expect(rendered).to have_css('.r_ass_ou_rsa_ou_aah .uncertain .c-detail-condition__raw.c-detail-condition__separator')
  end
    
  it 'An UNCERTAIN condition has the corresponding description' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect((page.css('.c-detail-condition.uncertain .c-detail-condition-text')[0]).text).to eq('Description of uncertain')
  end
  
  it 'An INELIGIBLE condition has the svg with ERROR mark' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition.ineligible svg')[0]['class']).to include('error')
  end

  it 'An INELIGIBLE condition has the corresponding description' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect((page.css('.c-detail-condition.ineligible .c-detail-condition-text')[0]).text).to eq('Description of ineligible')
  end
  
  it 'An ELIGIBLE condition has the svg with ERROR mark' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition.eligible svg')[0]['class']).to include('success')
  end
  
  it 'An ELIGIBLE condition has the corresponding description' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    expect((page.css('.c-detail-condition.eligible .c-detail-condition-text')[0]).text).to eq('Description of eligible')
  end
  
  it 'All conditions are rendered in the same order as given' do
    render partial: 'shared/detail_condition_list', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    order = page.css('.c-detail-condition').map { |e| e["data-status"] }
    expect(order).to eq(["ineligible", "eligible", "uncertain"])
  end
  
  it 'If there is an uncertain condition WITHOUT the "qpv" string, there is NO link to sigville' do
    args_without_qpv = nominal_args
    args_without_qpv[:conditions].find{ |x| x[:status] == "uncertain"}[:description] = "nothing special"
    render partial: 'shared/detail_condition_list', locals: args_without_qpv
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition.uncertain .c-detail-condition-text')[0].text).to include('nothing special')
    expect(page.css('.c-detail-condition.uncertain .c-detail-condition-text')[0].text).not_to include('sigville')
  end
  
  it 'If there is an uncertain condition WITH the "qpv" string, there is a link to sigville' do
    args_without_qpv = nominal_args
    args_without_qpv[:conditions].find{ |x| x[:status] == "uncertain"}[:description] = "a Qpv inside the sentence"
    render partial: 'shared/detail_condition_list', locals: args_without_qpv
    page = Nokogiri::HTML(rendered)
    expect(page.css('.c-detail-condition.uncertain .c-detail-condition-text')[0].text).to include('a Qpv inside the sentence.')
    expect(page.css('.c-detail-condition.uncertain .c-detail-condition-text')[0].text).to include('https://sig.ville.gouv.fr/adresses/recherche')
  end
  
  def nominal_args
    {
      :conditions => [
                      {:status => "ineligible",
                        :name => "r_age_sup_26_et_inscrit",
                        :description => "Description of ineligible"
                      }, 
                      {:status => "eligible",
                        :name => "r_ass_ou_rsa_ou_aah",
                        :description => "Description of eligible"
                      }, 
                      {:status => "uncertain",
                        :name => "r_age_sup_16_et_age_inf_26",
                        :description => "Description of uncertain"
                      }]
    }
  end


end
