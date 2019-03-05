# == Schema Information
#
# Table name: rule_checks
#
#  id         :integer(8)      not null, primary key
#  name       :string
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class RuleCheck < ApplicationRecord
end
