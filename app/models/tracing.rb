class Tracing < ApplicationRecord
  has_many :tracizations
  has_many :aids, through: :tracizations
  
  has_many :traces

  belongs_to :rule, optional: true
end
