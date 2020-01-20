# == Schema Information
#
# Table name: domain_filters
#
#  id          :integer(8)      not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  slug        :string
#

class DomainFilter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true

  has_many :axle_filters, dependent: :nullify
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
