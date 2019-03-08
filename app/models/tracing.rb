class Tracing < ApplicationRecord
  has_many :tracizations
  has_many :aids, through: :tracizations

  belongs_to :rule, optional: true
end
