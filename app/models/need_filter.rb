class NeedFilter < ApplicationRecord 
  extend FriendlyId

  after_save    { ExpireCache.call }
  after_update  { ExpireCache.call }
  after_destroy { ExpireCache.call }
  after_create  { ExpireCache.call }

  has_and_belongs_to_many :aids

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :axle_filter


  def should_generate_new_friendly_id?
    name_changed?
  end

end
