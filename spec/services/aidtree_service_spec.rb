require 'rails_helper'
require 'securerandom'

describe AidtreeService do

  inactive_and_eligible_aid_1   = nil
  inactive_and_eligible_aid_2   = nil
  active_and_uncertain_aid_1    = nil
  active_and_uncertain_aid_2    = nil
  inactive_and_uncertain_aid_1  = nil
  inactive_and_uncertain_aid_2  = nil
  active_and_ineligible_aid_1   = nil
  active_and_ineligible_aid_2   = nil
  inactive_and_ineligible_aid_1 = nil
  inactive_and_ineligible_aid_2 = nil
  the_asker = nil
  cache_layer = nil

  before(:all) do
    the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')

    Aid.delete_all # Hack needed when launching all tests

    r_adult = create(:rule, :be_an_adult, name: "r_adult")
    r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv, name: "r_adult_and_qpv")
    r_young = create(:rule, :not_be_an_adult, name: "r_young")
    c_contract_type = create(:contract_type, :contract_type_1, name: "c_contract_type")

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1'+ SecureRandom.hex, rule: r_adult, contract_type: c_contract_type)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2' + SecureRandom.hex, rule: r_adult, contract_type: c_contract_type)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1' + SecureRandom.hex, rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2' + SecureRandom.hex, rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1' + SecureRandom.hex, rule: r_adult_and_qpv, contract_type: c_contract_type)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2' + SecureRandom.hex, rule: r_adult_and_qpv, contract_type: c_contract_type)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1' + SecureRandom.hex, rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2' + SecureRandom.hex, rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1' + SecureRandom.hex, rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2' + SecureRandom.hex, rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1' + SecureRandom.hex, rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2' + SecureRandom.hex, rule: r_young, archived_at: DateTime.new)

  end

  describe ".go" do

    it 'Should not return nil' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result).not_to be nil
    end

    it 'Given 6 activated aids, should return 6 items' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result.size).to eq(6)
    end

    it 'All result must be a simple hash' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result.all? {|res| res.is_a?(Hash)}).to eq(true)
    end

    it 'All result must concern only the activated aids' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result.all? {|res| res["name"].start_with?("active")}).to eq(true)
    end

    describe 'Cache Read' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return('[ { "id": 1, "name": "active_and_eligible_aid_1", "what": null, "created_at": "2018-05-22T12:05:49.248Z", "updated_at": "2018-05-22T12:05:49.248Z", "slug": "active_and_eligible_aid_1", "short_description": null, "how_much": null, "additionnal_conditions": null, "how_and_when": null, "limitations": null, "rule_id": 1, "ordre_affichage": 0, "contract_type_id": 1, "archived_at": null, "last_update": null, "contract_type": { "id": 1, "name": "n1", "description": "d1", "created_at": "2018-05-22T12:05:49.221Z", "updated_at": "2018-05-22T12:05:49.221Z", "ordre_affichage": 0, "icon": null, "slug": "n1", "category": "aide", "business_id": "b1" } }, { "id": 5, "name": "active_and_uncertain_aid_1", "what": null, "created_at": "2018-05-22T12:05:49.284Z", "updated_at": "2018-05-22T12:05:49.284Z", "slug": "active_and_uncertain_aid_1", "short_description": null, "how_much": null, "additionnal_conditions": null, "how_and_when": null, "limitations": null, "rule_id": 4, "ordre_affichage": 0, "contract_type_id": 1, "archived_at": null, "last_update": null, "contract_type": { "id": 1, "name": "n1", "description": "d1", "created_at": "2018-05-22T12:05:49.221Z", "updated_at": "2018-05-22T12:05:49.221Z", "ordre_affichage": 0, "icon": null, "slug": "n1", "category": "aide", "business_id": "b1" } } ]')
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must have read key "all_activated_aids" from cache' do
        # given

        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(cache_layer).to have_received(:read).with("all_activated_aids")
      end
      it 'Must NOT write anything to cache' do
        # given

        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(cache_layer).not_to have_received(:write)
      end
      it 'Must fetch results from cache, if any' do
        # given
        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(result.size).to eq(2)
      end
    end
    describe 'Cache Write' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return(nil)
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must have read key "all_activated_aids" from cache' do
        # given

        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(cache_layer).to have_received(:read).with("all_activated_aids")
      end
      it 'Must WRITE the list to the cache' do
        # given

        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(cache_layer).to have_received(:write).with("all_activated_aids", anything)
      end
      it 'Must fetch results from DB' do
        # given
        # when
        result = AidtreeService.get_instance.go(the_asker)
        # then
        expect(result.size).to eq(6)
      end
    end



    it 'A result must have the format of an aid with its contract_type, if any' do

      # given
      result = AidtreeService.get_instance.go(the_asker)

      # when
      sut = result.detect{|item| item["name"].start_with? 'active_and_eligible_aid_1' }
      # remove existing IDs and TIMESTAMPs that could change between tests,
      # so that sut remains testable
      modify_hash_so_that_it_remains_testable(sut)
      # out of scope of this unit test : eligibility
      sut["eligibility"] = nil
      sut["name"] = "active_and_eligible_aid_1"
      sut["slug"] = "active_and_eligible_aid_1"

      # then
      expect(sut).to eq(
        {"id"=>"EXISTING",
          "name"=>"active_and_eligible_aid_1",
          "what"=>nil,
          "eligibility"=>nil,
          "created_at"=>"EXISTING",
          "updated_at"=>"EXISTING",
          "slug"=>"active_and_eligible_aid_1",
          "short_description"=>nil,
          "how_much"=>nil,
          "additionnal_conditions"=>nil,
          "how_and_when"=>nil,
          "limitations"=>nil,
          "rule_id"=>"EXISTING",
          "ordre_affichage"=>0,
          "contract_type_id"=>1,
          "archived_at"=>nil,
          "last_update"=>nil,
          "contract_type"=>
           {"id"=>"EXISTING",
            "name"=>"c_contract_type",
            "description"=>"d1",
            "created_at"=>"EXISTING",
            "updated_at"=>"EXISTING",
            "ordre_affichage"=>0,
            "icon"=>nil,
            "slug"=>"c_contract_type",
            "category"=>"aide",
            "business_id"=>"b1"}
        }
      )
    end

    it 'A result must have the format of an aid WITHOUT its contract_type, if NONE' do

      # given
      result = AidtreeService.get_instance.go(the_asker)

      # when
      sut = result.detect{|item| item["name"].start_with? 'active_and_ineligible_aid_1' }
      # remove existing IDs and TIMESTAMPs that could change between tests,
      # so that sut remains testable
      modify_hash_so_that_it_remains_testable(sut)
      # out of scope of this unit test : eligibility
      sut["eligibility"] = nil
      sut["name"] = "active_and_ineligible_aid_1"
      sut["slug"] = "active_and_ineligible_aid_1"

      # then
      expect(sut).to eq(
        {"id"=>"EXISTING",
          "name"=>"active_and_ineligible_aid_1",
          "what"=>nil,
          "eligibility"=>nil,
          "created_at"=>"EXISTING",
          "updated_at"=>"EXISTING",
          "slug"=>"active_and_ineligible_aid_1",
          "short_description"=>nil,
          "how_much"=>nil,
          "additionnal_conditions"=>nil,
          "how_and_when"=>nil,
          "limitations"=>nil,
          "rule_id"=>"EXISTING",
          "ordre_affichage"=>0,
          "contract_type_id"=>nil,
          "archived_at"=>nil,
          "last_update"=>nil
        }
      )
    end

    it 'ELIGIBLE aid must have a field "eligibility" equal to "eligible"' do
      pending("Calculation of result through Ruletree is not yet implemented")
      # given
      result = AidtreeService.get_instance.go(the_asker)
      # when
      sut = result.detect{|item| item["name"].start_with? 'active_and_eligible_aid_1' }
      # then
      expect(sut["eligibility"]).to eq "eligible"
    end

    it 'INELIGIBLE aid must have a field "eligibility" equal to "ineligible"' do
      pending("Calculation of result through Ruletree is not yet implemented")
      # given
      result = AidtreeService.get_instance.go(the_asker)
      # when
      sut = result.detect{|item| item["name"].start_with? 'active_and_ineligible_aid_1' }
      # then
      expect(sut["eligibility"]).to eq "ineligible"
    end

    it 'UNCERTAIN aid must have a field "eligibility" equal to "uncertain"' do
      pending("Calculation of result through Ruletree is not yet implemented")
      # given
      result = AidtreeService.get_instance.go(the_asker)
      # when
      sut = result.detect{|item| item["name"].start_with? 'active_and_uncertain_aid_1' }
      # then
      expect(sut["eligibility"]).to eq "uncertain"
    end

    def modify_hash_so_that_it_remains_testable(the_hash)
      the_hash["id"] = "EXISTING" if the_hash["id"]
      the_hash["rule_id"] = "EXISTING" if the_hash["rule_id"]
      the_hash["created_at"] = "EXISTING" if the_hash["created_at"]
      the_hash["updated_at"] = "EXISTING" if the_hash["updated_at"]
      the_hash["contract_type"]["created_at"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["created_at"]
      the_hash["contract_type"]["updated_at"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["updated_at"]
      the_hash["contract_type"]["id"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["id"]
    end



  end

end
