require 'rails_helper'

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

  before(:all) do
    the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')

    r_adult = create(:rule, :be_an_adult)
    r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv)
    r_young = create(:rule, :not_be_an_adult)
    c = create(:contract_type, :contract_type_1)

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult, contract_type: c)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2', rule: r_adult, contract_type: c)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1', rule: r_adult, archived_at: DateTime.new, contract_type: c)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2', rule: r_adult, archived_at: DateTime.new, contract_type: c)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1', rule: r_adult_and_qpv, contract_type: c)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2', rule: r_adult_and_qpv, contract_type: c)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1', rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2', rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1', rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2', rule: r_young, archived_at: DateTime.new)

  end

  describe ".go" do

    it 'Given 6 activated aids, should not return nil' do
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

    it 'A result must have the format of an aid with its contract_type, if any' do

      # given
      result = AidtreeService.get_instance.go(the_asker)

      # when
      sut = result.detect{|item| item["name"] == 'active_and_eligible_aid_1' }
      # hacks so that sut remains testable
      sut["created_at"] = "MODIFIED" 
      sut["updated_at"] = "MODIFIED"
      sut["contract_type"]["created_at"] = "MODIFIED"
      sut["contract_type"]["updated_at"] = "MODIFIED"

      # then
      expect(sut).to eq(
        {"id"=>1,
          "name"=>"active_and_eligible_aid_1",
          "what"=>nil,
          "created_at"=>"MODIFIED",
          "updated_at"=>"MODIFIED",
          "slug"=>"active_and_eligible_aid_1",
          "short_description"=>nil,
          "how_much"=>nil,
          "additionnal_conditions"=>nil,
          "how_and_when"=>nil,
          "limitations"=>nil,
          "rule_id"=>1,
          "ordre_affichage"=>0,
          "contract_type_id"=>1,
          "archived_at"=>nil,
          "last_update"=>nil,
          "contract_type"=>
           {"id"=>1,
            "name"=>"n1",
            "description"=>"d1",
            "created_at"=>"MODIFIED",
            "updated_at"=>"MODIFIED",
            "ordre_affichage"=>0,
            "icon"=>nil,
            "slug"=>"n1",
            "category"=>"aide",
            "business_id"=>"b1"}
        }
      )
    end

    # it 'A result must have the format of an aid without its contract_type, if none' do
    #   # given
    #   result = AidtreeService.get_instance.go(the_asker)
    #   # when
    #   sut = result.detect{|item| item["name"] == 'active_and_ineligible_aid_1' }
    #   sut[]
    #   # then
    #   expect(sut).to eq(
    #     {"id"=>1,
    #       "name"=>"active_and_ineligible_aid_1",
    #       "what"=>nil,
    #       "created_at"=>"2018-05-22T12:13:03.694Z",
    #       "updated_at"=>"2018-05-22T12:13:03.694Z",
    #       "slug"=>"active_and_eligible_aid_1",
    #       "short_description"=>nil,
    #       "how_much"=>nil,
    #       "additionnal_conditions"=>nil,
    #       "how_and_when"=>nil,
    #       "limitations"=>nil,
    #       "rule_id"=>1,
    #       "ordre_affichage"=>0,
    #       "contract_type_id"=>nil,
    #       "archived_at"=>nil,
    #       "last_update"=>nil
    #     }
    #   )
    # end

  end

end
