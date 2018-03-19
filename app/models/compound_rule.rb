class CompoundRule < ApplicationRecord
  belongs_to :rule
  belongs_to :slave_rule, class_name: 'Rule'
end

# == Schema Information
#
# Table name: compound_rules
#
#  id            :integer         not null, primary key
#  rule_id       :integer
#  slave_rule_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

