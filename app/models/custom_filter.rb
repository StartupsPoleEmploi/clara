class CustomFilter < ApplicationRecord 
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :custom_parent_filter
  has_and_belongs_to_many :aids


  def should_generate_new_friendly_id?
    name_changed?
  end

end
