class CreateRulesAndCompoundRules < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.string :name
      t.integer :variable_type
      t.timestamps
    end

    create_table :rules do |t|
      t.string  :name
      t.string  :value
      t.integer  :operator_type
      t.integer  :value_type
      t.integer :composition_type
      t.references :variable, foreign_key: true
      t.timestamps
    end

    create_table :compound_rules do |t|
      t.references :rule, index: true, foreign_key: true
      t.references :slave_rule, index: true
      t.timestamps
    end

    create_table :aids do |t|
      t.string :name
      t.text :description
      t.string :type
      t.timestamps
    end

    create_table :special_conditions do |t|
      t.belongs_to :rule, index: true
      t.belongs_to :aid, index: true
      t.belongs_to :location, index: true
      t.text :description
      t.timestamps
    end

    create_table :locations do |t|
      t.string :name
      t.timestamps
    end

    add_foreign_key :compound_rules, :rules, column: :slave_rule_id
    add_index :compound_rules, [:rule_id, :slave_rule_id], unique: true
    add_index :special_conditions, [:rule_id, :aid_id, :location_id], unique: true
 
  end
end
