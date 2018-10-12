class Level3Filter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :level2_filter

  has_and_belongs_to_many :aids
  


  def should_generate_new_friendly_id?
    name_changed?
  end

end
