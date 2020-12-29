class DropCustomRuleCheck < ActiveRecord::Migration[5.1]
  def change 
    drop_table :custom_rule_checks
  end
end
