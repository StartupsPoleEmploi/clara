require 'rails_helper'

describe ContractTypeService do

  describe ".slug_of_projet_pro" do
    it "Returns slug of projet-pro" do
      # given
      contract_type = create(:contract_type, :contract_type_1, name: 'slug-of-projet-pro', description: 'sth')
      # when
      output = ContractTypeService.new.slug_of_projet_pro      
      # then
      expect(output).to eq "slug-of-projet-pro"
    end
  end

end
