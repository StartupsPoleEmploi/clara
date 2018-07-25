require 'rails_helper'

describe AgeService do
  describe '.new_and_download' do
    it 'Returns a new age form with age filled from given asker' do
      #given
      asker = Asker.new
      asker.v_age = 'a_age'
      #when
      result = AgeService.new.new_and_download(asker)
      #then
      expect(result.class.to_s).to eq('AgeForm')
      expect(result.number_of_years).to eq('a_age')
    end
  end

  describe '.upload' do
    it 'Should inject an age into asker' do
    #given
    asker = Asker.new
    age = AgeForm.new
    age.number_of_years = 'age value'
    #when
    AgeService.new.upload(age, asker)
    #then
    expect(asker.v_age).to eq('age value')
    end
  end


end

