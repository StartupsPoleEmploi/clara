class CompoundRule < ApplicationRecord
  belongs_to :rule
  belongs_to :slave_rule, class_name: 'Rule'
end
