class Tracing < ApplicationRecord
  has_many :tracizations
  has_many :aids, through: :tracizations
  
  has_many :traces

  belongs_to :rule, optional: false

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }
end
