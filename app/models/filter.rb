class Filter < ApplicationRecord
  # belongs_to :aid, optional: true
  has_and_belongs_to_many :aids
  validates :name, presence: true, uniqueness: true
end
