class NeedFilter < ApplicationRecord 
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }

  has_and_belongs_to_many :aids

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :axle_filter


  def should_generate_new_friendly_id?
    slug.blank?
  end

end
