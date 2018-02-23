require 'rails_helper'

describe TabTitleHelper do
  def for_root_url
    OpenStruct.new({path: RoutesList.all_pathes["root_path"]})
  end
  def for_unknown_url
    OpenStruct.new({path: RoutesList.all_pathes["divide_by_zero_index_path"]})
  end
  def for_aides_url
    OpenStruct.new({path: RoutesList.all_pathes["aides_path"]})
  end
  def for_type_url
    OpenStruct.new({path: RoutesList.all_pathes["type_path"]})
  end
  def for_detail_url
    OpenStruct.new({path: RoutesList.all_pathes["detail_path"]})
  end
  describe '#calculate_title' do
    it 'without any title_data given, it returns the smallest possible title' do
      sut = TabTitleHelper::TitleCalculator.new(for_root_url)
      output = sut.calculate_title('')
      expect(output).to eq ('Clara – un service Pôle emploi')
    end
    it 'returns the given title for the home page' do
      sut = TabTitleHelper::TitleCalculator.new(for_root_url)
      output = sut.calculate_title('[given title]')
      expect(output).to eq ('[given title]')
    end
    it 'returns the calculated title for a all questions asked' do
      RoutesList.asked_questions.each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = TabTitleHelper::TitleCalculator.new(request)
        output = sut.calculate_title('[given title]')
        expect(output).to eq('[given title] | Clara – un service Pôle emploi')
      end
    end
    it 'returns the calculated title when url is unknown, but title_data is given' do
      sut = TabTitleHelper::TitleCalculator.new(for_unknown_url)
      output = sut.calculate_title('[given title]')
      expect(output).to eq ('[given title] | Clara – un service Pôle emploi')
    end
    it 'returns the calculated title for the index page of all aides' do
      sut = TabTitleHelper::TitleCalculator.new(for_aides_url)
      output = sut.calculate_title('[given title]')
      expect(output).to eq ('[given title] | Clara – un service Pôle emploi')
    end
    it 'returns the calculated title for each type page' do
      sut = TabTitleHelper::TitleCalculator.new(for_type_url)
      output = sut.calculate_title('[given title]')
      expect(output).to eq ('Découvrez les aides de type [given title] | Clara – un service Pôle emploi')
    end
    it 'returns the calculated title for each detail page' do
      sut = TabTitleHelper::TitleCalculator.new(for_detail_url)
      output = sut.calculate_title('[given title]')
      expect(output).to eq ("Présentation de l'aide [given title] | Clara – un service Pôle emploi")
    end

  end
end
