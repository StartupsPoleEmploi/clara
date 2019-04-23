# == Schema Information
#
# Table name: contract_types
#
#  id              :integer(8)      not null, primary key
#  name            :string
#  description     :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  ordre_affichage :integer(4)
#  icon            :string
#  slug            :string
#  category        :string
#  plural          :string
#

class ContractType < ApplicationRecord 
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }
  
  SLUG_FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/

  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :ordre_affichage, presence: true, numericality: { only_integer: true }

  scope :aides, -> { where(category: 'aide') }
  scope :dispositifs, -> { where(category: 'dispositif') }
  scope :for_admin, -> {order(ordre_affichage: :asc)}

  def should_generate_new_friendly_id?
    slug.blank?
  end
  
end
