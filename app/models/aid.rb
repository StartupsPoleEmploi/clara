# == Schema Information
#
# Table name: aids
#
#  id                     :integer(4)      not null, primary key
#  name                   :string
#  what                   :text
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  slug                   :string
#  short_description      :string
#  how_much               :text
#  additionnal_conditions :text
#  how_and_when           :text
#  limitations            :text
#  rule_id                :integer(8)
#  ordre_affichage        :integer(4)
#  contract_type_id       :integer(8)
#  archived_at            :datetime
#  source                 :text
#

class Aid < ApplicationRecord
  extend FriendlyId  
  include PgSearch
  
  # BUG : callback not always called. Trello card should appear about that bug. 
  # Until solved, the callback will be triggered manually.
  # before_save :_calculate_status

  after_initialize do |me|
    me.archived_at ||= me.created_at if new_record?
  end

  def _calculate_status
    new_status = "Brouillon"
    if _is(Aid.activated)
      new_status = "Publiée"
    elsif self.archived_at != nil && self.archived_at == self.created_at && _is(Aid.linked_to_rule) && _is(Aid.redacted)
      new_status = "En attente de relecture"  
    elsif self.archived_at != nil && self.archived_at != self.created_at
      new_status = "Archivée"    
    end
    self.status = new_status 
    ap "calculate_status for #{self.name} : #{new_status}"
  end

  def _is(within_scope)
    within_scope.where(:id => self.id).present?
  end

  # See https://github.com/Casecommons/pg_search
  pg_search_scope :roughly_spelled_like,
                  :against => %i(name short_description what how_much additionnal_conditions how_and_when limitations),
                  :ignoring => :accents,
                  :using => {
                    :tsearch => {prefix: true},
                    :dmetaphone => {},
                  }

  has_many :tracizations
  has_many :tracings, through: :tracizations

  has_and_belongs_to_many :filters
  has_and_belongs_to_many :need_filters
  has_and_belongs_to_many :custom_filters

  has_paper_trail ignore: [:updated_at]

  
  friendly_id :name, use: :slugged
  belongs_to :rule, optional: true
  belongs_to :contract_type, optional: false

  validates :name, presence: true, uniqueness: true  
  validates :ordre_affichage, presence: true

  scope :unarchived, -> { where(archived_at: nil) }
  scope :redacted, -> { where.not(what: [nil, ""]).where.not(how_much: [nil, ""]).where.not(additionnal_conditions: [nil, ""]).where.not(how_and_when: [nil, ""]).where.not(limitations: [nil, ""]) }
  scope :linked_to_rule, -> { where.not(rule_id: nil) }
  scope :activated,  -> { self.unarchived.linked_to_rule.redacted }
  scope :for_admin, -> {includes(:contract_type).order('contract_types.ordre_affichage ASC', ordre_affichage: :asc)}
  
  def should_generate_new_friendly_id?
    slug.blank?
  end

end
