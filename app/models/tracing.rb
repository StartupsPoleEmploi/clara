class Tracing < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :tracizations, dependent: :destroy
  has_many :aids, through: :tracizations, dependent: :destroy
  
  has_many :traces, dependent: :destroy

  belongs_to :rule, optional: false

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }
end
