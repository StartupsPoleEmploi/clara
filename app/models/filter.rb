# == Schema Information
#
# Table name: filters
#
#  id          :integer(8)      not null, primary key
#  name        :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :string
#  slug        :string
#

class Filter < ApplicationRecord
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }


  has_and_belongs_to_many :aids
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
