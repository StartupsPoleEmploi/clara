require 'rails_helper'
require 'uri'

# describe BanService do 

#   http_layer = nil
#   env_layer = nil

#   describe "For testing purpose" do
#     before do
#       ban_layer = instance_double("BanService")
#       allow(ban_layer).to receive(:get_zip_city_region).and_return("faked_value")
#       BanService.set_instance(ban_layer)
#     end
#     after do
#       BanService.set_instance(nil)
#     end
#     it '.get_zip_city_region Can be stubbed easily' do
#       sut = BanService.get_instance
#       output = sut.get_zip_city_region('59035')
#       expect(output).to eq("faked_value")
#     end
#   end
#   describe '.get_zip_city_region' do
#     describe '59035 Lille' do
#       before(:each) do
#         env_layer = instance_double("EnvService")
#         allow(env_layer).to receive(:ara_url_ban).and_return("https://url_of_ban?q=")
#         EnvService.set_instance(env_layer)
#       end
#       after(:each) do
#         EnvService.set_instance(nil)
#         HttpService.set_instance(nil)
#       end

#       it 'External service should be called with the right url ' do
#         # given
#         http_layer = spy('HttpService')
#         HttpService.set_instance(http_layer)
#         # when
#         BanService.get_instance.get_zip_city_region('59035')
#         # then
#         expect(http_layer).to have_received(:get).with URI.parse('https://url_of_ban?q=rue&citycode=59035') 
#       end
#       it 'Should return "59440" and "Avesnelles" inside an array' do
#         http_layer = instance_double("HttpService")
#         allow(http_layer).to receive(:get).and_return({"version"=>"draft", "limit"=>5, "features"=>[{"type"=>"Feature", "properties"=>{"x"=>767428.1, "postcode"=>"59440", "context"=>"59, Nord, Hauts-de-France (Nord-Pas-de-Calais)", "city"=>"Avesnelles", "score"=>0.8216363636363636, "type"=>"street", "name"=>"Rue Léo Lagrange", "y"=>7002706.3, "label"=>"Rue Léo Lagrange 59440 Avesnelles", "importance"=>0.038, "citycode"=>"59035", "id"=>"59035_0260_2fca35"}, "geometry"=>{"type"=>"Point", "coordinates"=>[3.941823, 50.118996]}}, {"type"=>"Feature", "properties"=>{"x"=>767600.2, "postcode"=>"59440", "context"=>"59, Nord, Hauts-de-France (Nord-Pas-de-Calais)", "city"=>"Avesnelles", "score"=>0.8213818181818181, "type"=>"street", "name"=>"Rue Charles Sery", "y"=>7002491.2, "label"=>"Rue Charles Sery 59440 Avesnelles", "importance"=>0.0352, "citycode"=>"59035", "id"=>"59035_0060_8cc5ff"}, "geometry"=>{"type"=>"Point", "coordinates"=>[3.944191, 50.117046]}}, {"type"=>"Feature", "properties"=>{"x"=>767062.3, "postcode"=>"59440", "context"=>"59, Nord, Hauts-de-France (Nord-Pas-de-Calais)", "city"=>"Avesnelles", "score"=>0.8213636363636363, "type"=>"street", "name"=>"Rue du Mont Inculte", "y"=>7002203.4, "label"=>"Rue du Mont Inculte 59440 Avesnelles", "importance"=>0.035, "citycode"=>"59035", "id"=>"59035_0321_5a6091"}, "geometry"=>{"type"=>"Point", "coordinates"=>[3.936631, 50.114519]}}, {"type"=>"Feature", "properties"=>{"x"=>767225.3, "postcode"=>"59440", "context"=>"59, Nord, Hauts-de-France (Nord-Pas-de-Calais)", "city"=>"Avesnelles", "score"=>0.8213454545454545, "type"=>"street", "name"=>"Rue Victor Hugo", "y"=>7002182.2, "label"=>"Rue Victor Hugo 59440 Avesnelles", "importance"=>0.0348, "citycode"=>"59035", "id"=>"59035_0480_269769"}, "geometry"=>{"type"=>"Point", "coordinates"=>[3.938904, 50.114311]}}, {"type"=>"Feature", "properties"=>{"x"=>767813.0, "postcode"=>"59440", "context"=>"59, Nord, Hauts-de-France (Nord-Pas-de-Calais)", "city"=>"Avesnelles", "score"=>0.8212545454545455, "type"=>"street", "name"=>"Rue du Moulinet", "y"=>7003027.0, "label"=>"Rue du Moulinet 59440 Avesnelles", "importance"=>0.0338, "citycode"=>"59035", "id"=>"59035_0340_820624"}, "geometry"=>{"type"=>"Point", "coordinates"=>[3.947252, 50.121834]}}], "filters"=>{"citycode"=>"59035"}, "attribution"=>"BAN", "type"=>"FeatureCollection", "licence"=>"ODbL 1.0", "query"=>"rue"}.to_json)
#         HttpService.set_instance(http_layer)
#         expect(BanService.get_instance.get_zip_city_region('59035')).to eq ['59440', 'Avesnelles', 'Hauts-de-France (Nord-Pas-de-Calais)']
#       end
#       it 'Should return String "erreur_ville_introuvable" if nothing is found' do
#         http_layer = instance_double("HttpService")
#         allow(http_layer).to receive(:get).and_return({"version"=>"draft", "limit"=>5, "features"=>[{"type"=>"Feature", "properties"=>{}, "geometry"=>{}}], "filters"=>{"citycode"=>"59035"}, "attribution"=>"BAN", "type"=>"FeatureCollection", "licence"=>"ODbL 1.0", "query"=>"rue"}.to_json)
#         HttpService.set_instance(http_layer)
#         expect(BanService.get_instance.get_zip_city_region('59035')).to eq 'erreur_ville_introuvable'
#       end
#       it 'Should return String "erreur_ville_introuvable" if no answer is given' do
#         http_layer = instance_double("HttpService")
#         allow(http_layer).to receive(:get).and_return({}.to_json)
#         HttpService.set_instance(http_layer)
#         expect(BanService.get_instance.get_zip_city_region('59035')).to eq 'erreur_ville_introuvable'
#       end
#       it 'Should return String "erreur_service_indisponible" if "timeout" string in the answer' do
#         http_layer = instance_double("HttpService")
#         allow(http_layer).to receive(:get).and_return({"timeout"=>"yes"}.to_json)
#         HttpService.set_instance(http_layer)
#         expect(BanService.get_instance.get_zip_city_region('59035')).to eq 'erreur_service_indisponible'
#       end
#       it 'Should return String "erreur_technique" if no string is passed' do
#         http_layer = instance_double("HttpService")
#         allow(http_layer).to receive(:get).and_return({}.to_json)
#         HttpService.set_instance(http_layer)
#         expect(BanService.get_instance.get_zip_city_region(Date.new)).to eq 'erreur_technique'
#       end
#     end
    


#   end
# end
