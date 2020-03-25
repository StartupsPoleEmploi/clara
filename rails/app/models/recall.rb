class Recall  < ApplicationRecord
  belongs_to :aid, optional: false
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :trigger_at, presence: true

  before_save :default_values
  def default_values
    ap "def-------------"
    self.trigger_at = self.trigger_at.change({ hour: 7, min: 30, sec: 0 })
  end


end
