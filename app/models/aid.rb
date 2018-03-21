class Aid < ApplicationRecord
  extend FriendlyId  

  has_paper_trail ignore: [:updated_at]
  
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

end

# == Schema Information
#
# Table name: aids
#
#  id                     :integer         not null, primary key
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
#  ordre_affichage        :integer         default("0")
#  contract_type_id       :integer(8)
#  archived_at            :datetime
#  last_update            :text
#

