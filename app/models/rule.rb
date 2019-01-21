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
  # validate :kind, 
  # validate :validate_non_empty_rule, 
  #          :validate_non_ambiguous_type, 
  #          :validate_simple_rule_mandatory_fields, 
  #          :validate_complex_rule_mandatory_fields

  # def validate_non_empty_rule
  #   return unless is_empty_rule?
  #   errors.add(:non_empty_rule, "Rule cannot be empty")
  # end

  # def validate_simple_rule_mandatory_fields
  #   return if is_complex_rule?
  #   return if (variable.present? && operator_type.present? && value_eligible.present?)
  #   errors.add(:simple_rule_mandatory_fields, "Variable, operator_type and value_eligible are mandatory")
  # end

  # def validate_non_ambiguous_type
  #   return unless is_ambiguous_rule?
  #   errors.add(:non_ambiguous_type, "Rule cannot be both simple and complex")
  # end

  # def validate_complex_rule_mandatory_fields
  #   return if is_simple_rule?
  #   return if (composition_type.present? && slave_rules.length > 0)
  #   errors.add(:complex_rule_mandatory_fields, "slave_rules and composition_type are mandatory")
  # end

  # def is_simple_rule?
  #   variable.present? || operator_type.present? || value_eligible.present?
  # end

  # def is_complex_rule?
  #   slave_rules.length > 0 || composition_type.present?
  # end

  # def is_ambiguous_rule?
  #   is_simple_rule? && is_complex_rule?
  # end

  # def is_empty_rule?
  #   !is_simple_rule? && !is_complex_rule?
  # end

end
