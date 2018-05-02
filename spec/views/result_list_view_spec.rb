require 'rails_helper'
require 'spec_helper'
require 'nokogiri'

describe 'shared/_result_list' do 

  it 'Should NOT render without args' do
    render 
    expect(rendered).not_to have_css('.c-result-list')
  end
  
  it 'Should render correct namespace with nominal args' do
    render partial: 'shared/result_list', locals: nominal_args
    expect(rendered).to have_css('.c-result-list')
  end

  it 'Should render the correct root css class' do
    render partial: 'shared/result_list', locals: nominal_args
    expect(rendered).to have_css('.c-result-list.c-result-list--the_clazz')
  end

  it 'Should NOT render without lines' do
    modify_args = nominal_args
    modify_args[:lines] = []
    render partial: 'shared/result_list', locals: modify_args
    expect(rendered).not_to have_css('.c-result-list')
  end

  it 'Should render as much lines as given' do
    render partial: 'shared/result_list', locals: nominal_args
    expect(rendered).to have_css('.c-result-line', count: 2)
  end

  def nominal_args
    {
      :strong_title=>"My Title",
      :clazz=>"the_clazz",
      :lines=>[{},{}]
    }
  end

end
