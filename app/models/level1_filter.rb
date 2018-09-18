class Level1Filter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

end
