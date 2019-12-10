class CreateCustomRuleChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_rule_checks do |t|
      t.references :rule, foreign_key: true
      t.string :result
      t.string :name
      t.text :hsh

      t.timestamps
    end
  end
end
