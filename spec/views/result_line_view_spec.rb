require 'rails_helper'
require 'spec_helper'
require 'nokogiri'

describe 'shared/_result_line' do 

  it 'Should render with correct namespace' do
    render 
    expect(rendered).to have_css('.c-result-line')
  end
  
  it 'Should render line if required' do
    render partial: 'shared/result_line', locals: nominal_args
    expect(rendered).to have_css('.c-result-line__content')
  end

  it 'Should render a data-id per line that concatenate "clazz" and "contract_type_id"' do
    render partial: 'shared/result_line', locals: nominal_args
    page = Nokogiri::HTML(rendered)
    data_id = page.css('.c-result-line__content')[0]["data-id"]
    expect(data_id).to eq("uncertain__age-biz")
  end

  it 'Should render a data-id per line that concatenate "clazz" and slugified "contract_type_id"' do
    local_args = nominal_args
    local_args[:line]["contract_type_business_id"] = "appui à l'embauche"
    render partial: 'shared/result_line', locals: local_args
    page = Nokogiri::HTML(rendered)
    data_id = page.css('.c-result-line__content')[0]["data-id"]
    expect(data_id).to eq("uncertain__appui-a-l-embauche")
  end

  it 'Should NOT render line if NOT required' do
    render
    expect(rendered).not_to have_css('.c-result-line__content')
  end
  
  it 'Should render title if required' do
    local_args = nominal_args
    local_args[:show_title] = true
    render partial: 'shared/result_line', locals: local_args
    expect(rendered).to have_css('.c-result-line__icon')
  end

  it 'Should NOT render title if NOT required' do
    local_args = nominal_args
    local_args[:show_title] = false
    render partial: 'shared/result_line', locals: local_args
    expect(rendered).not_to have_css('.c-result-line__icon')
  end

  it 'Should render expander if apply' do
    local_args = nominal_args
    local_args[:show_expander] = true
    render partial: 'shared/result_line', locals: local_args
    expect(rendered).to have_css('.c-result-line__action')
  end

  it 'Should NOT render expander if apply' do
    local_args = nominal_args
    local_args[:show_expander] = false
    render partial: 'shared/result_line', locals: local_args
    expect(rendered).not_to have_css('.c-result-line__action')
  end
  
  it 'Should rendered ordered aides if line is rendered' do
    local_args = nominal_args
    render partial: 'shared/result_line', locals: local_args
    expect(rendered).to have_css('.c-result-aid', count: 4)
    page = Nokogiri::HTML(rendered) 
    result_appear_in_order = page.css('.c-result-aid__title').collect(&:text).map(&:strip)
    expect(result_appear_in_order).to eq(["name219", "name220", "name221", "name222"])
  end
    
  def nominal_args
    {
      :line =>  {
        "aids" => [{"id" => 9,
          "name" => "name220",
          "ordre_affichage" => 220,
          "short_description" => "",
          "slug" => "name220"
        }, {"id" => 11,
          "name" => "name222",
          "ordre_affichage" => 222,
          "short_description" => "",
          "slug" => "name222"
        }, {"id" => 12,
          "name" => "name221",
          "ordre_affichage" => 221,
          "short_description" => "",
          "slug" => "name221"
        }, {"id" => 8,
          "name" => "name219",
          "ordre_affichage" => 219,
          "short_description" => "any",
          "slug" => "name219"
        }],
        "contract_type_id" => 5,
        "contract_type_business_id" => "age-biz",
        "id" => "122c7d9f-97d2-404c-86fe-6c865c92d51b",
        "description" => "Toutes les aides liées à l'âge du demandeur d'emploi",
        "icon" => "",
        "order" => 84,
        "unfold" => {
          "value" => false
        }
      }, 
      :show_title => true, 
      :clazz => "uncertain", 
      :show_expander => true
    }
  end


end
