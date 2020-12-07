class Offanswer  < ApplicationRecord
  validates :value, presence: true

  after_save    { ExpireCacheJob.perform_later } if Rails.env.production?
  after_update  { ExpireCacheJob.perform_later } if Rails.env.production?
  after_destroy { ExpireCacheJob.perform_later } if Rails.env.production?
  after_create  { ExpireCacheJob.perform_later } if Rails.env.production?

end
