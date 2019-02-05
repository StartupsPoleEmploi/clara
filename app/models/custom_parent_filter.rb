class CustomParentFilter < ApplicationRecord 
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }


  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  has_many :custom_filters, dependent: :nullify

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
