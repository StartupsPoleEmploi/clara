require 'rails_helper'

describe RequestPathService do 
  describe "For testing purpose" do
    before(:each) do
      request_path_layer = instance_double("RequestPathService")
      allow(request_path_layer).to receive(:question_path?).and_return('fake_question_value')
      allow(request_path_layer).to receive(:root_path?).and_return('fake_root_value')
      allow(request_path_layer).to receive(:type_path?).and_return('fake_type_value')
      allow(request_path_layer).to receive(:detail_path?).and_return('fake_detail_value')
      allow(request_path_layer).to receive(:aides_path?).and_return('fake_aides_value')
      RequestPathService.set_instance(request_path_layer)
    end
    after(:each) do
      RequestPathService.set_instance(nil)
    end
    it '.question_path? Can be stubbed easily' do
      sut = RequestPathService.get_instance(nil)
      output = sut.question_path?
      expect(output).to eq('fake_question_value')
    end
    it '.root_path? Can be stubbed easily' do
      sut = RequestPathService.get_instance(nil)
      output = sut.root_path?
      expect(output).to eq('fake_root_value')
    end
    it '.type_path? Can be stubbed easily' do
      sut = RequestPathService.get_instance(nil)
      output = sut.type_path?
      expect(output).to eq('fake_type_value')
    end
    it '.detail_path? Can be stubbed easily' do
      sut = RequestPathService.get_instance(nil)
      output = sut.detail_path?
      expect(output).to eq('fake_detail_value')
    end
    it '.aides_path? Can be stubbed easily' do
      sut = RequestPathService.get_instance(nil)
      output = sut.aides_path?
      expect(output).to eq('fake_aides_value')
    end
  end
  describe "Pathes" do
    before(:each) do
      RequestPathService.dont_stub
    end
    it ".root_path? return true if the request path is the root path" do
      request = OpenStruct.new({path: RoutesList.all_pathes["root_path"]})
      sut = RequestPathService.get_instance(request)
      expect(sut.root_path?).to eq(true)
    end
    it ".root_path? return false if the request path IS NOT the root path" do
      RoutesList.all_pathes.except("root_path").each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.root_path?).to eq(false)
      end
    end

    it ".question_path? return true if the request path belongs to a question" do
      RoutesList.questions.each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.question_path?).to eq(true)
      end
    end
    it ".question_path? return false if the request path DOES NOT belongs to a question" do
      RoutesList.not_questions.each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.question_path?).to eq(false)
      end
    end

    it ".type_path? return true if the request path belongs to a contract type" do
      request = OpenStruct.new({path: RoutesList.all_pathes["type_path"]})
      sut = RequestPathService.get_instance(request)
      expect(sut.type_path?).to eq(true)
    end
    it ".type_path? return false if the request path DOES NOT belongs to a contract type" do
      RoutesList.all_pathes.except("type_path").each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.type_path?).to eq(false)
      end
    end

    it ".detail_path? return true if the request path belongs to a aid detail" do
      request = OpenStruct.new({path: RoutesList.all_pathes["detail_path"]})
      sut = RequestPathService.get_instance(request)
      expect(sut.detail_path?).to eq(true)
    end
    it ".detail_path? return false if the request path DOES NOT belongs to a aid detail" do
      RoutesList.all_pathes.except("detail_path").each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.detail_path?).to eq(false)
      end
    end

    it ".aides_path? return true if the request path belongs to the main aides page" do
      request = OpenStruct.new({path: RoutesList.all_pathes["aides_path"]})
      sut = RequestPathService.get_instance(request)
      expect(sut.aides_path?).to eq(true)
    end
    it ".aides_path? return false if the request path DOES NOT belongs to the main aides page" do
      RoutesList.all_pathes.except("aides_path").each do |route, route_val|
        request = OpenStruct.new({path: route_val})
        sut = RequestPathService.get_instance(request)
        expect(sut.aides_path?).to eq(false)
      end
    end
  end
end
