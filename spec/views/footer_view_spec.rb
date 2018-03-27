require 'rails_helper'
require 'spec_helper'

describe 'Footer view' do 


    describe 'namespace' do
      it 'Should not render without request data', type: :view do
        render partial: 'shared/footer'
        expect(rendered).not_to have_css('.c-footer')
      end      
      it 'Should render with correct namespace if request is provided', type: :view do
        render partial: 'shared/footer', locals: {the_request: for_root_url}
        expect(rendered).to have_css('.c-footer')
      end      
    end
    describe 'simple links' do
      it 'Should render with link to terms and conditions', type: :view do
        render partial: 'shared/footer', locals: {the_request: for_root_url}
        expect(rendered).to have_link("Conditions générales d'utilisation", href: "/conditions-generales-d-utilisation")
      end      
      it 'Should render with link to pole-emploi', type: :view do
        render partial: 'shared/footer', locals: {the_request: for_root_url}
        expect(rendered).to have_link("propulsé par POLE EMPLOI", href: "https://www.pole-emploi.fr/")
      end      
    end

    describe 'link to "Toutes les aides"' do
      it 'Display link to all aides', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).to have_link('Toutes nos aides', href: '/aides')
      end         
      it 'Has a special class attached on home', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_link('Toutes nos aides', href: '/aides', class: 'c-link-to-all-aides__home')
      end         
      it 'Has a special class attached on page other than home', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).to have_link('Toutes nos aides', href: '/aides', class: 'c-link-to-all-aides__not_home')
      end         
    end

    describe 'Copyright and motherhome' do
      it 'Is displayed on home inside the first column, not third', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__content.first .c-footer-motherhome')
        expect(rendered).not_to have_css('.c-footer__content.third .c-footer-motherhome')
      end         
      it 'Is displayed outsite of home inside the third column, not first', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).to have_css('.c-footer__content.third .c-footer-motherhome')
        expect(rendered).not_to have_css('.c-footer__content.first .c-footer-motherhome')
      end         
    end

    describe 'All links to AIDES' do
      it 'Display no links to aides if there are none', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [], the_request: for_root_url}
        expect(rendered).not_to have_css('.c-footer__link-to-aides')
      end
      it 'Display 1 link to aides if there is 1', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__link-to-aides', count: 1)
      end
      it 'Display 2 links to aides if there are 2', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type, default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__link-to-aides', count: 2)
      end      
      it 'Display 0 links, even if there are 2 aids, outside of home', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type, default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).not_to have_css('.c-footer__link-to-aides')
      end      
    end

    describe 'Title AIDES' do
      it 'Display no title AIDES if there are none', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [], the_request: for_root_url}
        expect(rendered).not_to have_css('.c-footer__contenttitle--aides')
      end
      it 'Display title AIDES if there is 1', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__contenttitle--aides', count: 1)
      end
      it 'Display title AIDES if there are 2', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type, default_contract_type], dispositifs: [], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__contenttitle--aides', count: 1)
      end      
      it 'DONT Display title AIDES if there are 2, outside of home', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type, default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).not_to have_css('.c-footer__contenttitle--aides')
      end      
    end

    describe 'All links to DISPOSITIFS' do
      it 'Display no links to dispositifs if there are none', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [], the_request: for_root_url}
        expect(rendered).not_to have_css('.c-footer__link-to-dispositifs')
      end
      it 'Display 1 link to dispositifs if there is 1', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [default_contract_type], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__link-to-dispositifs', count: 1)
      end
      it 'Display 2 links to dispositifs if there are 2', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [default_contract_type, default_contract_type], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__link-to-dispositifs', count: 2)
      end      
      it 'Display 0 links, even if there are 2 dispositifs, outside of home', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [default_contract_type, default_contract_type], the_request: not_for_root_url}
        expect(rendered).not_to have_css('.c-footer__link-to-dispositifs')
      end      
    end

    describe 'Title DISPOSITIFS' do
      it 'Display no title DISPOSITIFS if there are none', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [], the_request: for_root_url}
        expect(rendered).not_to have_css('.c-footer__contenttitle--dispositifs')
      end
      it 'Display title DISPOSITIFS if there is 1', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [default_contract_type], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__contenttitle--dispositifs', count: 1)
      end
      it 'Display title DISPOSITIFS if there are 2', type: :view do
        render partial: 'shared/footer', locals: {aides: [], dispositifs: [default_contract_type, default_contract_type], the_request: for_root_url}
        expect(rendered).to have_css('.c-footer__contenttitle--dispositifs', count: 1)
      end      
      it 'DONT Display title DISPOSITIFS if there are 2, outside of home', type: :view do
        render partial: 'shared/footer', locals: {aides: [default_contract_type, default_contract_type], dispositifs: [], the_request: not_for_root_url}
        expect(rendered).not_to have_css('.c-footer__contenttitle--aides')
      end      
    end

    def default_contract_type
      {'name' => 'type_name', 'slug' => 'type_slug'}
    end
    def for_root_url
      OpenStruct.new({path: RoutesList.all_pathes["root_path"]})
    end
    def not_for_root_url
      OpenStruct.new({path: RoutesList.all_pathes["aides_path"]})
    end
end
