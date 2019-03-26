require 'rails_helper'

describe AgeService do

  describe '.new_and_download' do
    it 'Returns age_type from given asker' do
      #given
      asker = Asker.new
      asker.v_age = '16'
      #when
      result = AgeService.new.new_and_download(asker)
      #then
      expect(result.number_of_years).to eq('16')
    end
    it 'Returns a new age form' do
      #given
      asker = Asker.new
      #when
      result = AgeService.new.new_and_download(asker)
      #then
      expect(result.class.to_s).to eq('AgeForm')
    end
  end

  describe '.upload' do
    it 'should inject age_type into asker' do
      #given
      asker = Asker.new
      age = AgeForm.new
      age.number_of_years = 'age_type' 
      #when
      AgeService.new.upload(age, asker)
      #then
      expect(asker.v_age).to eq('age_type')
    end
  end
end
