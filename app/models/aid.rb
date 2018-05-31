class Aid < ApplicationRecord
  extend FriendlyId  

  has_paper_trail ignore: [:updated_at]

  has_many :filters
  
  friendly_id :name, use: :slugged
  belongs_to :rule, optional: true
  belongs_to :contract_type, optional: true

  validates :name, presence: true, uniqueness: true  

  scope :unarchived, -> { where(archived_at: nil) }
  scope :linked_to_rule, -> { where.not(rule_id: nil) }
  scope :activated,  -> { self.unarchived.linked_to_rule }
  
  def should_generate_new_friendly_id?
    name_changed?
  end

  def self.eager_loaded
    Aid.activated.includes(:contract_type).includes(rule: [:slave_rules, :variable])
  end

end
