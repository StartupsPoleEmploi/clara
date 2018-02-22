require 'rails_helper'

describe 'shared/_detail_item_remark' do 

  it 'Should NOT render without nominal data' do
    render 
    expect(rendered).not_to have_css('.c-detail-item-remark')
  end
  
  it 'Should render in correct namespace with nominal content' do
    render partial: 'shared/detail_item_remark', locals: nominal_args 
    expect(rendered).to have_css('.c-detail-item-remark')
  end
  
  it 'Should NOT render in correct namespace with EMPTY content' do
    local_args = nominal_args
    local_args[:content] = ''
    render partial: 'shared/detail_item_remark', locals: local_args 
    expect(rendered).not_to have_css('.c-detail-item-remark')
  end

  it 'Should NOT render in correct namespace with BAD content' do
    local_args = nominal_args
    local_args[:content] = '<p>&nbsp;</p>\r\n<p>&nbsp;</p>'
    render partial: 'shared/detail_item_remark', locals: local_args 
    expect(rendered).not_to have_css('.c-detail-item-remark')
  end
  
  def nominal_args
    {
      content: '<p>something</p>'
    }
  end
end
