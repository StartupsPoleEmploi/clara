# create_table "rules", id: :serial, force: :cascade do |t|
#   t.string "name"
#   t.string "status"
#   t.string "value_eligible"
#   t.integer "composition_type"
#   t.integer "variable_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.text "description"
#   t.string "value_ineligible"
#   t.string "kind"
#   t.string "operator_kind"
#   t.index ["variable_id"], name: "index_rules_on_variable_id"
# end
class Rule < ApplicationRecord
  include Prefixable

  before_save :default_values
  def default_values
    self.simulated ||= 'missing_simulation'
  end

  enum operator_kind: ListOperatorKind.new.call

  has_paper_trail ignore: [:updated_at]

  enum composition_type: [:and_rule, :or_rule]

  has_many :compound_rules, dependent: :delete_all
  has_many :slave_rules, through: :compound_rules
  belongs_to :variable, optional: true

  has_many :aids
  has_many :contract_type
  has_many :custom_rule_checks, dependent: :delete_all


  validates :name, uniqueness: true, format: { with: /\A[A-Za-z_0-9-]+\z/, message: "Seules les lettres minuscules et majuscules sans accent, le tiret bas et haut,  et les chiffres sont autorisés" }
  validates_with RuleValidator

end
