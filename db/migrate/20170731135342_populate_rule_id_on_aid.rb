class PopulateRuleIdOnAid < ActiveRecord::Migration[5.1]
  def up
    execute("update aids set rule_id = (select rule_id from special_conditions where special_conditions.aid_id = aids.id limit 1)")
  end

  def down
    execute("update aids set rule_id = null")
  end
end