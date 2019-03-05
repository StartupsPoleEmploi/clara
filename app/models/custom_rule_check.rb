# == Schema Information
#
# Table name: custom_rule_checks
#
#  id         :integer(8)      not null, primary key
#  rule_id    :integer(8)
#  result     :string
#  name       :string
#  hsh        :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class CustomRuleCheck < ApplicationRecord
  belongs_to :rule
  serialize :hsh, Hash

  validates :name, presence: true
end
