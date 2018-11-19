class AxleFilter < ApplicationRecord 
  extend FriendlyId

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged


  has_many :need_filters
  belongs_to :domain_filter

  def should_generate_new_friendly_id?
    name_changed?
  end

end
