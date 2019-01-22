class Rule < ApplicationRecord
  include Prefixable

  after_save    { ExpireCache.call }
  after_update  { ExpireCache.call }
  after_destroy { ExpireCache.call }
  after_create  { ExpireCache.call }

  has_paper_trail ignore: [:updated_at]

  enum operator_type: [:eq, :not_equal, :more_than, :less_than, :more_or_equal_than, :less_or_equal_than, :starts_with, :amongst, :not_amongst]
  enum composition_type: [:and_rule, :or_rule]

  has_many :compound_rules, dependent: :delete_all
  has_many :slave_rules, through: :compound_rules
  belongs_to :variable, optional: true

  has_many :aids
  has_many :contract_type
  has_many :custom_rule_checks, dependent: :delete_all


  validates :name, uniqueness: true
  validates_with RuleValidator

end
