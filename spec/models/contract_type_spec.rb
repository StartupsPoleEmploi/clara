require 'rails_helper'

describe ContractType, type: :model do

  describe 'database columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
    it { is_expected.to have_db_column(:ordre_affichage) }
    it { is_expected.to have_db_column(:icon) }
    it { is_expected.to have_db_column(:slug) }
    it { is_expected.to have_db_column(:category) }
    it { is_expected.to have_db_column(:business_id) }
  end

  describe 'validations' do
    describe 'globally' do
      it 'is valid when all fields are different' do
        contract_type_1 = create_contract_type_1
        contract_type_2 = create_contract_type_2
        expect(contract_type_1.valid?).to eq true
        expect(contract_type_2.valid?).to eq true      
      end      
    end
    describe 'name' do
      it 'is valid with a name' do
        # given
        contract_type = ContractType.new(name: 'any')
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:name].length).to eq 0
      end      
      it 'is invalid without a name' do
        # given
        contract_type = empty_contract_type
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:name].length).to eq 1
      end
      it 'is invalid with 2 same name' do
        # given
        contract_type_1 = create_contract_type_1
        contract_type_2 = create_contract_type_2
        # when
        contract_type_2.name = contract_type_1.name 
        # then
        expect(contract_type_2.valid?).to eq false
      end
    end
    describe 'description' do
      it 'is invalid without a description' do
        # given
        contract_type = empty_contract_type
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:description].length).to eq 1
      end
      it 'is valid with a description' do
        # given
        contract_type = ContractType.new(description: 'any')
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:description].length).to eq 0
      end
      it 'is invalid with 2 same description' do
        # given
        contract_type_1 = create_contract_type_1
        contract_type_2 = create_contract_type_2
        # when
        contract_type_2.description = contract_type_1.description 
        # then
        expect(contract_type_2.valid?).to eq false
      end
    end
    describe 'business_id' do
      it 'is invalid with 2 same business_id' do
        # given
        contract_type_1 = create_contract_type_1
        contract_type_2 = create_contract_type_2
        # when
        contract_type_2.business_id = contract_type_1.business_id 
        # then
        expect(contract_type_2.valid?).to eq false
      end
      it 'is valid with a business_id' do
        # given
        contract_type = create_contract_type_1
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:business_id].length).to eq 0
      end      
      it 'is invalid without a business_id' do
        # given
        contract_type = create_contract_type_1
        contract_type.business_id = nil
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:business_id].length).not_to eq 0
      end
      it 'is invalid with a business_id that is not like a slug' do
        # given
        contract_type = create_contract_type_1
        contract_type.business_id = 'Not a slug, obviously'
        # when
        contract_type.valid?
        # then
        expect(contract_type.errors[:business_id].length).not_to eq 0
      end
    end

  end

  describe 'querying' do
    it 'can be retrieved thanks to slugged name' do
      # given
      contract_type_1 = create_contract_type_1
      # when
      output = ContractType.find_by(slug: contract_type_1.name)
      # then
      expect(output).to eq contract_type_1      
    end
    it 'can list all aides category easily' do
      contract_type_1 = create_contract_type_1
      expect(ContractType.aides).to eq [contract_type_1]
    end
    it 'can list all dispositifs easily' do
      contract_type_2 = create_contract_type_2
      expect(ContractType.dispositifs).to eq [contract_type_2]
    end
  end

  def create_contract_type_1
    create(:contract_type, :contract_type_1)
  end

  def create_contract_type_2
    create(:contract_type, :contract_type_2)
  end

  def empty_contract_type
    ContractType.new
  end
end
