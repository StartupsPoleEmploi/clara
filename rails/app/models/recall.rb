class Recall  < ApplicationRecord
  belongs_to :aid, optional: false
  validates :email, presence: true
  validates :trigger_at, presence: true
end
