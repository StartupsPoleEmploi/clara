class Monitor < ApplicationRecord
  has_many :monitorizations
  has_many :aids, through: :monitorizations

  belongs_to :rule, optional: true
end
