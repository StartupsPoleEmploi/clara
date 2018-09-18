class Level3Filter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :aids
  
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

end
