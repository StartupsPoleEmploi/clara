require 'rails_helper'

describe QpvService do 
  describe "For testing purpose" do
    before(:each) do
      qpv_layer = instance_double("QpvService")
      allow(qpv_layer).to receive(:isDetailedQPV).and_return("unexisting_isqpv_value")
      allow(qpv_layer).to receive(:setDetailedQPV).and_return("unexisting_setqpv_value")
      QpvService.set_instance(qpv_layer)
    end
    after(:each) do
      QpvService.set_instance(nil)
    end
    it '.isDetailedQPV Can be stubbed easily' do
      sut = QpvService.get_instance
      output = sut.isDetailedQPV('num_adresse', 'nom_voie', 'code_postal', 'nom_commune')
      expect(output).to eq('unexisting_isqpv_value')
    end
    it '.setDetailedQPV Can be stubbed easily' do
      sut = QpvService.get_instance
      output = sut.setDetailedQPV('num_adresse', 'nom_voie', 'code_postal', 'nom_commune')
      expect(output).to eq('unexisting_setqpv_value')
    end
  end
  describe '.isDetailedQPV' do
    describe 'unavailable remote service' do
      before do
        disable_http_service
      end
      after do
        enable_http_service
      end
      it 'Should return "erreur_injoignable" if remote service is unavailable' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'erreur_injoignable'
      end
    end
    describe 'http service returns erratic data' do
      before do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return("irrelevant_stuff")
        HttpService.set_instance(http_layer)
      end
      after do
        enable_http_service
      end
      it 'Should return "erreur_injoignable" if remote service returns erratic data' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'erreur_injoignable'
      end
    end
    describe 'http service returns explicitly "error"' do
      before do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return("error")
        HttpService.set_instance(http_layer)
      end
      after do
        enable_http_service
      end
      it 'Should return "est_indetermine" if remote service returns explicitly "error"' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'est_indetermine'
      end
    end
    describe 'http service returns a timeout' do
      before do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return("timeout")
        HttpService.set_instance(http_layer)
      end
      after do
        enable_http_service
      end
      it 'Should return "service_indisponible" if remote service returns erratic data' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'service_indisponible'
      end
    end
    describe 'en_qpv' do
      before do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return("is_qpv")
        HttpService.set_instance(http_layer)
      end
      after do
        enable_http_service
      end
      it 'Should return "en_qpv" if remote service return "en_qpv"' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'en_qpv'
      end
    end
    describe 'hors_qpv' do
      before do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return("is_not_qpv")
        HttpService.set_instance(http_layer)
      end
      after do
        enable_http_service
      end
      it 'Should return "hors_qpv" if remote service return "is_not_qpv"' do
        output = QpvService.get_instance.isDetailedQPV('11', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'hors_qpv'
      end
    end
    describe 'no num address is given' do
      it 'Should return "erreur_numero_manquant" if no num address is given' do
        output = QpvService.get_instance.isDetailedQPV('', 'rue du bar', '81523', 'Chem')
        expect(output).to eq 'erreur_numero_manquant'
      end
    end
    
  end
end
