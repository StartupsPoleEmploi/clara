class CreateRuleChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :rule_checks do |t|
      t.string :name

      t.timestamps
    end
  end
end
