# == Schema Information
#
# Table name: axle_filters
#
#  id               :integer(8)      not null, primary key
#  name             :string
#  description      :text
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  slug             :string
#  domain_filter_id :integer(8)
#

class AxleFilter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged


  has_many :need_filters
  belongs_to :domain_filter

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
