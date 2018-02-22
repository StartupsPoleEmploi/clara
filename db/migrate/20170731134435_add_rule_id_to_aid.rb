class AddRuleIdToAid < ActiveRecord::Migration[5.1]
  def change
    add_reference :aids, :rule, index: true
  end
end
