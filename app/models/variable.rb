class Variable < ApplicationRecord
  include Prefixable
  has_paper_trail ignore: [:updated_at]

  # Deprecated, please remove ASAP
  enum variable_type: [:integer, :string, :selectionnable], _prefix: true

  enum variable_kind: {
    integer: "integer", 
    string: "string", 
    selectionnable: "selectionnable", 
  }

  has_many :rule
  validates :variable_kind, presence: true

end
