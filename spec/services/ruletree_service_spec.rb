require 'rails_helper'

describe RuletreeService do


  the_asker = nil
  cache_layer = nil

  before do
    the_asker = Asker.new(v_age: '42', v_spectacle: 'non')
    # r_adult = create(:rule, :be_an_adult, name: "r_adult_rts")
    # r_spectacle = create(:rule, :be_a_spectacle, name: "r_spectacle_rts")
    r_adult_and_spectacle = create(:rule, :be_an_adult_and_a_spectacles, name: "r_adult_and_spectacle_rts")
    r_adult_or_spectacle = create(:rule, :be_an_adult_or_a_spectacles, name: "r_adult_or_spectacle_rts")

  end

  describe 'instantiation' do
    
    describe 'Cache Read, already something inside the database' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return('[{}]')
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must have read key "all_rules_json" from cache' do
        # given

        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).to have_received(:read).with("all_rules_json")
      end
      it 'Must NOT write anything to cache' do
        # given

        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).not_to have_received(:write)
      end
      it 'Must fetch results from cache, if any' do
        # given
        # when
        sut = RuletreeService.get_instance._all_rules
        # then
        expect(sut.size).to eq(1)
      end
    end
    describe 'Cache Write, nothing inside the database' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return(nil)
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must WRITE the list to the cache' do
        # given
        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).to have_received(:write).with("all_rules_json", anything)
      end
      it 'Must fetch results from DB' do
        # given
        # when
        sut = RuletreeService.get_instance._all_rules_json
        # then
        expect(RuletreeService.get_instance._all_rules.size).to eq(6)
      end
    end

  end

  describe ".resolve" do
    it 'Should not return nil' do
      pending "not a priority"
      # given
      # when
      result = RuletreeService.get_instance.resolve
      # then
      expect(result).not_to be nil
    end
  end

end
