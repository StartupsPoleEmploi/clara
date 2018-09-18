class Level2Filter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true

  has_many :level3_filters
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

end
