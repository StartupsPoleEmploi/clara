class DropRuleCheck < ActiveRecord::Migration[5.1]
  def change 
    drop_table :rule_checks
  end
end
