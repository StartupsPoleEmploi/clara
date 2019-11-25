class AddCascadeDeleteToForeignKeys < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:compound_rules, :rules)
      remove_foreign_key :compound_rules, column: "slave_rule_id"
      add_foreign_key "compound_rules", "rules", column: "slave_rule_id", on_delete: :cascade
    end
  end
end
