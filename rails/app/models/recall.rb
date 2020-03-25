class Recall  < ApplicationRecord
  belongs_to :aid, optional: false
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :trigger_at, presence: true
end
