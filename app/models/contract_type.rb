class ContractType < ApplicationRecord 
  extend FriendlyId
  
  SLUG_FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/

  friendly_id :name, use: :slugged
  validates :description, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :business_id, uniqueness: true, presence: true, format: {with: Regexp.new('\A' + '[a-z0-9-]+' + '\z')}

  scope :aides, -> { where(category: 'aide') }
  scope :dispositifs, -> { where(category: 'dispositif') }

  def should_generate_new_friendly_id?
    name_changed?
  end
  
end

# == Schema Information
#
# Table name: contract_types
#
#  id              :integer(8)      not null, primary key
#  name            :string
#  description     :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  ordre_affichage :integer         default("0")
#  icon            :string
#  slug            :string
#  category        :string
#  business_id     :string
#

