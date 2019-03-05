require "rails_helper"

describe Admin::RulesController, type: :request do
  before(:each) do 
    ENV["ARA_SKIP_ADMIN_AUTH"] = "true"
  end 
  after(:each) do 
    ENV["ARA_SKIP_ADMIN_AUTH"] = nil
  end 
  describe "POST save_simulation" do
    it "Can be successful" do
      adult_rule = create(:rule, :be_an_adult)
      post save_simulation_admin_rule_path(id: adult_rule.id), params: {simulation:{result: 'a', name: 'a'}, asker: {v_handicap: 'a'}}
      expect(response.status).to eq(201)
    end
    it "Can be unsuccessful" do
      adult_rule = create(:rule, :be_an_adult)
      post save_simulation_admin_rule_path(id: adult_rule.id), params: {simulation:{result: 'a'}, asker: {v_handicap: 'a'}}
      expect(response.status).to eq(422)
    end
  end
  describe "DELETE delete_simulation" do
    it "Can be successful" do
      custom_rule_check = create(:custom_rule_check, name: 'any')
      adult_rule = create(:rule, :be_an_adult, custom_rule_checks: [custom_rule_check])
      delete delete_simulation_admin_rule_path(id: custom_rule_check.id)
      expect(response.status).to eq(204)
    end
  end
  describe "GET resolve_admin_rule_path" do
    it "Can be successful" do
      adult_rule = create(:rule, :be_an_adult)
      get resolve_admin_rule_path(id: adult_rule.id), params: {asker: {v_handicap: 'a'}}
      expect(response.status).to eq(200)
    end
  end
end
