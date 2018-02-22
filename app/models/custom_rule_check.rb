class CustomRuleCheck < ApplicationRecord
  belongs_to :rule
  serialize :hsh, Hash

  validates :name, presence: true
end
