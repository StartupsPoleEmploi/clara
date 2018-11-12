class CustomParentFilter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  has_many :custom_filters

  def should_generate_new_friendly_id?
    name_changed?
  end

end
