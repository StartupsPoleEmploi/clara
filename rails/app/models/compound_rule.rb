# == Schema Information
#
# Table name: compound_rules
#
#  id            :integer(4)      not null, primary key
#  rule_id       :integer(4)
#  slave_rule_id :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class CompoundRule < ApplicationRecord
  belongs_to :rule
  belongs_to :slave_rule, class_name: 'Rule'
end
