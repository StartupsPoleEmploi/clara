class Tracing < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :tracizations
  has_many :aids, through: :tracizations
  
  has_many :traces

  belongs_to :rule, optional: false

  after_save { ExpireCacheJob.perform_later } if Rails.env.production?
  after_update { ExpireCacheJob.perform_later } if Rails.env.production?
  after_destroy { ExpireCacheJob.perform_later } if Rails.env.production?
  after_create { ExpireCacheJob.perform_later } if Rails.env.production?
end
