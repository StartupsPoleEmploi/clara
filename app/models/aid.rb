class Aid < ApplicationRecord
  extend FriendlyId  
  include PgSearch

  after_save    { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_update  { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_destroy { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_create  { Rails.cache.clear;ActivatedModelsService.instance.regenerate }

  # See https://github.com/Casecommons/pg_search
  pg_search_scope :roughly_spelled_like,
                  :against => %i(name short_description what how_much additionnal_conditions how_and_when limitations),
                  :using => {
                    :tsearch => {},
                    :dmetaphone => {},
                  }

  has_and_belongs_to_many :filters
  has_and_belongs_to_many :need_filters
  has_and_belongs_to_many :custom_filters

  has_paper_trail ignore: [:updated_at]

  
  friendly_id :name, use: :slugged
  belongs_to :rule, optional: true
  belongs_to :contract_type, optional: true

  validates :name, presence: true, uniqueness: true  
  validates :ordre_affichage, presence: true

  scope :unarchived, -> { where(archived_at: nil) }
  scope :linked_to_rule, -> { where.not(rule_id: nil) }
  scope :activated,  -> { self.unarchived.linked_to_rule }
  
  def should_generate_new_friendly_id?
    name_changed?
  end

end
