class Filter < ApplicationRecord
  extend FriendlyId

  has_and_belongs_to_many :aids
  validates :name, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

end
